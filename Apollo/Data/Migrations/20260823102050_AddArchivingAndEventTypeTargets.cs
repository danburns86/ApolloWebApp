using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddArchivingAndEventTypeTargets : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsArchived",
                table: "Productions",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "DefaultToRehearsalSchedule",
                table: "ProductionEventTypes",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "DefaultToTechSchedule",
                table: "ProductionEventTypes",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsArchived",
                table: "Productions");

            migrationBuilder.DropColumn(
                name: "DefaultToRehearsalSchedule",
                table: "ProductionEventTypes");

            migrationBuilder.DropColumn(
                name: "DefaultToTechSchedule",
                table: "ProductionEventTypes");
        }
    }
}
