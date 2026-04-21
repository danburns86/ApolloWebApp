using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddAccidentBook : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsRiddorReportable",
                table: "IncidentRecords");

            migrationBuilder.RenameColumn(
                name: "TreatmentGiven",
                table: "IncidentRecords",
                newName: "WitnessDetails");

            migrationBuilder.RenameColumn(
                name: "Timestamp",
                table: "IncidentRecords",
                newName: "IncidentDateTime");

            migrationBuilder.RenameColumn(
                name: "RiddorReportedDate",
                table: "IncidentRecords",
                newName: "DateClosed");

            migrationBuilder.RenameColumn(
                name: "PersonsInvolved",
                table: "IncidentRecords",
                newName: "RootCause");

            migrationBuilder.RenameColumn(
                name: "Description",
                table: "IncidentRecords",
                newName: "ReportedBy");

            migrationBuilder.AddColumn<string>(
                name: "SpecificAssemblyPoint",
                table: "Rooms",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "DescriptionOfEvent",
                table: "IncidentRecords",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "ImmediateActionTaken",
                table: "IncidentRecords",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "InjuriesSustained",
                table: "IncidentRecords",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "InvestigatedBy",
                table: "IncidentRecords",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "InvestigationFindings",
                table: "IncidentRecords",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "LinkedMaintenanceIssueId",
                table: "IncidentRecords",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "PersonInvolvedName",
                table: "IncidentRecords",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "PersonInvolvedType",
                table: "IncidentRecords",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<int>(
                name: "Status",
                table: "IncidentRecords",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "Type",
                table: "IncidentRecords",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateTable(
                name: "ComplianceConfigurations",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    MainAssemblyPoint = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    EmergencyPhoneNumber = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    SiteAddress = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    RAWarningDays = table.Column<int>(type: "int", nullable: false),
                    CoshhWarningDays = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ComplianceConfigurations", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "ContractorRAMS",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SupplierId = table.Column<int>(type: "int", nullable: false),
                    MaintenanceIssueId = table.Column<int>(type: "int", nullable: true),
                    DocumentTitle = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    FilePath = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    SubmissionDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    ExpiryDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    IsReviewed = table.Column<bool>(type: "bit", nullable: false),
                    ReviewedBy = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ApprovalNotes = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ContractorRAMS", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ContractorRAMS_MaintenanceIssues_MaintenanceIssueId",
                        column: x => x.MaintenanceIssueId,
                        principalTable: "MaintenanceIssues",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ContractorRAMS_Suppliers_SupplierId",
                        column: x => x.SupplierId,
                        principalTable: "Suppliers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "IncidentEvidence",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IncidentRecordId = table.Column<int>(type: "int", nullable: false),
                    FilePath = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Caption = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_IncidentEvidence", x => x.Id);
                    table.ForeignKey(
                        name: "FK_IncidentEvidence_IncidentRecords_IncidentRecordId",
                        column: x => x.IncidentRecordId,
                        principalTable: "IncidentRecords",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ContractorRAMS_MaintenanceIssueId",
                table: "ContractorRAMS",
                column: "MaintenanceIssueId");

            migrationBuilder.CreateIndex(
                name: "IX_ContractorRAMS_SupplierId",
                table: "ContractorRAMS",
                column: "SupplierId");

            migrationBuilder.CreateIndex(
                name: "IX_IncidentEvidence_IncidentRecordId",
                table: "IncidentEvidence",
                column: "IncidentRecordId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ComplianceConfigurations");

            migrationBuilder.DropTable(
                name: "ContractorRAMS");

            migrationBuilder.DropTable(
                name: "IncidentEvidence");

            migrationBuilder.DropColumn(
                name: "SpecificAssemblyPoint",
                table: "Rooms");

            migrationBuilder.DropColumn(
                name: "DescriptionOfEvent",
                table: "IncidentRecords");

            migrationBuilder.DropColumn(
                name: "ImmediateActionTaken",
                table: "IncidentRecords");

            migrationBuilder.DropColumn(
                name: "InjuriesSustained",
                table: "IncidentRecords");

            migrationBuilder.DropColumn(
                name: "InvestigatedBy",
                table: "IncidentRecords");

            migrationBuilder.DropColumn(
                name: "InvestigationFindings",
                table: "IncidentRecords");

            migrationBuilder.DropColumn(
                name: "LinkedMaintenanceIssueId",
                table: "IncidentRecords");

            migrationBuilder.DropColumn(
                name: "PersonInvolvedName",
                table: "IncidentRecords");

            migrationBuilder.DropColumn(
                name: "PersonInvolvedType",
                table: "IncidentRecords");

            migrationBuilder.DropColumn(
                name: "Status",
                table: "IncidentRecords");

            migrationBuilder.DropColumn(
                name: "Type",
                table: "IncidentRecords");

            migrationBuilder.RenameColumn(
                name: "WitnessDetails",
                table: "IncidentRecords",
                newName: "TreatmentGiven");

            migrationBuilder.RenameColumn(
                name: "RootCause",
                table: "IncidentRecords",
                newName: "PersonsInvolved");

            migrationBuilder.RenameColumn(
                name: "ReportedBy",
                table: "IncidentRecords",
                newName: "Description");

            migrationBuilder.RenameColumn(
                name: "IncidentDateTime",
                table: "IncidentRecords",
                newName: "Timestamp");

            migrationBuilder.RenameColumn(
                name: "DateClosed",
                table: "IncidentRecords",
                newName: "RiddorReportedDate");

            migrationBuilder.AddColumn<bool>(
                name: "IsRiddorReportable",
                table: "IncidentRecords",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }
    }
}
