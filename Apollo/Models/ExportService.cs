using Apollo.Data;
using Apollo.Models;
using ClosedXML.Excel;
using Microsoft.EntityFrameworkCore;

namespace Apollo.Services
{
    public class ExportService
    {
        private readonly IDbContextFactory<ApplicationDbContext> _dbFactory;

        public ExportService(IDbContextFactory<ApplicationDbContext> dbFactory)
        {
            _dbFactory = dbFactory;
        }

        public async Task<byte[]> GeneratePatRegisterAsync()
        {
            using var context = await _dbFactory.CreateDbContextAsync();

            // 1. Fetch Assets requiring PAT, including their latest result
            var assets = await context.Assets
                .Include(a => a.Room)
                .Include(a => a.InspectionHistory)
                .Where(a => a.RequiresPAT || a.VisualOnly)
                .OrderBy(a => a.AssetTag)
                .ToListAsync();

            using var workbook = new XLWorkbook();
            var ws = workbook.Worksheets.Add("PAT Asset Register");

            // 2. Set Landscape Orientation & Print Settings
            ws.PageSetup.PageOrientation = XLPageOrientation.Landscape;
            ws.PageSetup.PaperSize = XLPaperSize.A4Paper;
            ws.PageSetup.Margins.Top = 0.5;
            ws.PageSetup.Margins.Bottom = 0.5;
            ws.PageSetup.Margins.Left = 0.3;
            ws.PageSetup.Margins.Right = 0.3;

            // 3. Header Row
            var headers = new string[] {
                "Asset Tag", "Description", "Make/Model", "Location", "Class",
                "Visual", "Earth (Ω)", "Insul. (MΩ)", "Leak. (mA)",
                "Last Test", "Status", "Next Due"
            };

            for (int i = 0; i < headers.Length; i++)
            {
                var cell = ws.Cell(1, i + 1);
                cell.Value = headers[i];
                cell.Style.Font.Bold = true;
                cell.Style.Fill.BackgroundColor = XLColor.FromHtml("#2c3e50");
                cell.Style.Font.FontColor = XLColor.White;
            }

            // 4. Data Rows
            int row = 2;
            foreach (var asset in assets)
            {
                // Get the latest PAT/Visual record
                var latest = asset.InspectionHistory
                    .Where(h => h.Type == InspectionType.PAT || h.Type == InspectionType.Visual)
                    .OrderByDescending(h => h.InspectionDate)
                    .FirstOrDefault();

                ws.Cell(row, 1).Value = asset.AssetTag;
                ws.Cell(row, 2).Value = asset.Name;
                ws.Cell(row, 3).Value = $"{asset.Manufacturer} {asset.Model}";
                ws.Cell(row, 4).Value = asset.Room?.Name ?? "N/A";
                ws.Cell(row, 5).Value = asset.ApplianceClass.ToString();

                // Metrics
                ws.Cell(row, 6).Value = (latest != null) ? "Pass" : "-"; // Visual is implied pass if record exists
                ws.Cell(row, 7).Value = latest?.EarthBond?.ToString("F2") ?? "-";
                ws.Cell(row, 8).Value = latest?.Insulation?.ToString("F2") ?? "-";
                ws.Cell(row, 9).Value = latest?.Leakage?.ToString("F2") ?? "-";

                ws.Cell(row, 10).Value = latest?.InspectionDate.ToShortDateString() ?? "Never";
                ws.Cell(row, 11).Value = asset.PATStatus;
                ws.Cell(row, 12).Value = asset.NextPATDue?.ToShortDateString() ?? "-";

                // Color code the status
                if (asset.PATStatus == "Expired") ws.Cell(row, 11).Style.Font.FontColor = XLColor.Red;
                if (asset.PATStatus == "Valid") ws.Cell(row, 11).Style.Font.FontColor = XLColor.Green;

                row++;
            }

            // 5. Final Styling
            ws.Columns().AdjustToContents();
            ws.SheetView.FreezeRows(1);

            using var stream = new MemoryStream();
            workbook.SaveAs(stream);
            return stream.ToArray();
        }
    }
}