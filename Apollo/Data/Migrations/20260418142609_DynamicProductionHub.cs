using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class DynamicProductionHub : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "RequiresProjection",
                table: "Productions");

            migrationBuilder.RenameColumn(
                name: "Type",
                table: "Productions",
                newName: "CategoryId");

            migrationBuilder.RenameColumn(
                name: "Category",
                table: "ProductionRoles",
                newName: "CategoryId");

            migrationBuilder.CreateTable(
                name: "ProductionCategories",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IconClass = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductionCategories", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Productions_CategoryId",
                table: "Productions",
                column: "CategoryId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductionRoles_CategoryId",
                table: "ProductionRoles",
                column: "CategoryId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductionEvents_ProductionId",
                table: "ProductionEvents",
                column: "ProductionId");

            migrationBuilder.AddForeignKey(
                name: "FK_ProductionEvents_Productions_ProductionId",
                table: "ProductionEvents",
                column: "ProductionId",
                principalTable: "Productions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_ProductionRoles_ProductionCategories_CategoryId",
                table: "ProductionRoles",
                column: "CategoryId",
                principalTable: "ProductionCategories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Productions_ProductionCategories_CategoryId",
                table: "Productions",
                column: "CategoryId",
                principalTable: "ProductionCategories",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProductionEvents_Productions_ProductionId",
                table: "ProductionEvents");

            migrationBuilder.DropForeignKey(
                name: "FK_ProductionRoles_ProductionCategories_CategoryId",
                table: "ProductionRoles");

            migrationBuilder.DropForeignKey(
                name: "FK_Productions_ProductionCategories_CategoryId",
                table: "Productions");

            migrationBuilder.DropTable(
                name: "ProductionCategories");

            migrationBuilder.DropIndex(
                name: "IX_Productions_CategoryId",
                table: "Productions");

            migrationBuilder.DropIndex(
                name: "IX_ProductionRoles_CategoryId",
                table: "ProductionRoles");

            migrationBuilder.DropIndex(
                name: "IX_ProductionEvents_ProductionId",
                table: "ProductionEvents");

            migrationBuilder.RenameColumn(
                name: "CategoryId",
                table: "Productions",
                newName: "Type");

            migrationBuilder.RenameColumn(
                name: "CategoryId",
                table: "ProductionRoles",
                newName: "Category");

            migrationBuilder.AddColumn<bool>(
                name: "RequiresProjection",
                table: "Productions",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }
    }
}
