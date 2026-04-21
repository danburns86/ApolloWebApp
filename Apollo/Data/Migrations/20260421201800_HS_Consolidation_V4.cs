using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class HS_Consolidation_V4 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "ExceptionNote",
                table: "RoomFireSafetyAssignments");

            migrationBuilder.DropColumn(
                name: "Narrative_HazardsFound",
                table: "RiskAssessments");

            migrationBuilder.DropColumn(
                name: "IsCompleted",
                table: "FireActionPlanItems");

            migrationBuilder.AddColumn<string>(
                name: "EntryMethod",
                table: "IncidentRecords",
                type: "nvarchar(max)",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "EntryMethod",
                table: "IncidentRecords");

            migrationBuilder.AddColumn<string>(
                name: "ExceptionNote",
                table: "RoomFireSafetyAssignments",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Narrative_HazardsFound",
                table: "RiskAssessments",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "IsCompleted",
                table: "FireActionPlanItems",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }
    }
}
