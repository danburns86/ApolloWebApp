using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class LinkedKeyBunch : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_ProductionRoles_LinkedKeyBunchId",
                table: "ProductionRoles",
                column: "LinkedKeyBunchId");

            migrationBuilder.AddForeignKey(
                name: "FK_ProductionRoles_Bunches_LinkedKeyBunchId",
                table: "ProductionRoles",
                column: "LinkedKeyBunchId",
                principalTable: "Bunches",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProductionRoles_Bunches_LinkedKeyBunchId",
                table: "ProductionRoles");

            migrationBuilder.DropIndex(
                name: "IX_ProductionRoles_LinkedKeyBunchId",
                table: "ProductionRoles");
        }
    }
}
