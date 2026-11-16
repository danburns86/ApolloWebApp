using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddProductionSortAndDep : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "DepMemberId",
                table: "ProductionCrews",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "SortOrder",
                table: "ProductionCategories",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_ProductionCrews_DepMemberId",
                table: "ProductionCrews",
                column: "DepMemberId");

            migrationBuilder.AddForeignKey(
                name: "FK_ProductionCrews_Members_DepMemberId",
                table: "ProductionCrews",
                column: "DepMemberId",
                principalTable: "Members",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProductionCrews_Members_DepMemberId",
                table: "ProductionCrews");

            migrationBuilder.DropIndex(
                name: "IX_ProductionCrews_DepMemberId",
                table: "ProductionCrews");

            migrationBuilder.DropColumn(
                name: "DepMemberId",
                table: "ProductionCrews");

            migrationBuilder.DropColumn(
                name: "SortOrder",
                table: "ProductionCategories");
        }
    }
}
