using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class PerformanceInfo2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PerformanceCrewOverride_Performances_PerformanceId",
                table: "PerformanceCrewOverride");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PerformanceCrewOverride",
                table: "PerformanceCrewOverride");

            migrationBuilder.RenameTable(
                name: "PerformanceCrewOverride",
                newName: "PerformanceCrewOverrides");

            migrationBuilder.RenameIndex(
                name: "IX_PerformanceCrewOverride_PerformanceId",
                table: "PerformanceCrewOverrides",
                newName: "IX_PerformanceCrewOverrides_PerformanceId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PerformanceCrewOverrides",
                table: "PerformanceCrewOverrides",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_PerformanceCrewOverrides_Performances_PerformanceId",
                table: "PerformanceCrewOverrides",
                column: "PerformanceId",
                principalTable: "Performances",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_PerformanceCrewOverrides_Performances_PerformanceId",
                table: "PerformanceCrewOverrides");

            migrationBuilder.DropPrimaryKey(
                name: "PK_PerformanceCrewOverrides",
                table: "PerformanceCrewOverrides");

            migrationBuilder.RenameTable(
                name: "PerformanceCrewOverrides",
                newName: "PerformanceCrewOverride");

            migrationBuilder.RenameIndex(
                name: "IX_PerformanceCrewOverrides_PerformanceId",
                table: "PerformanceCrewOverride",
                newName: "IX_PerformanceCrewOverride_PerformanceId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_PerformanceCrewOverride",
                table: "PerformanceCrewOverride",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_PerformanceCrewOverride_Performances_PerformanceId",
                table: "PerformanceCrewOverride",
                column: "PerformanceId",
                principalTable: "Performances",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
