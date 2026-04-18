using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddReportNavigationProperties : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_Performances_ProductionId",
                table: "Performances",
                column: "ProductionId");

            migrationBuilder.AddForeignKey(
                name: "FK_Performances_Productions_ProductionId",
                table: "Performances",
                column: "ProductionId",
                principalTable: "Productions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Performances_Productions_ProductionId",
                table: "Performances");

            migrationBuilder.DropIndex(
                name: "IX_Performances_ProductionId",
                table: "Performances");
        }
    }
}
