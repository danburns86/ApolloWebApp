using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddProductionCastAndContactOverrides : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsFullRun",
                table: "ProductionCrews");

            migrationBuilder.AddColumn<string>(
                name: "CustomContactNumber",
                table: "ProductionCrews",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "ProductionCasts",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProductionId = table.Column<int>(type: "int", nullable: false),
                    CharacterName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    MemberId = table.Column<int>(type: "int", nullable: true),
                    DepMemberId = table.Column<int>(type: "int", nullable: true),
                    ExternalName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CustomContactNumber = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductionCasts", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductionCasts_Members_DepMemberId",
                        column: x => x.DepMemberId,
                        principalTable: "Members",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProductionCasts_Members_MemberId",
                        column: x => x.MemberId,
                        principalTable: "Members",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProductionCasts_Productions_ProductionId",
                        column: x => x.ProductionId,
                        principalTable: "Productions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProductionCasts_DepMemberId",
                table: "ProductionCasts",
                column: "DepMemberId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductionCasts_MemberId",
                table: "ProductionCasts",
                column: "MemberId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductionCasts_ProductionId",
                table: "ProductionCasts",
                column: "ProductionId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ProductionCasts");

            migrationBuilder.DropColumn(
                name: "CustomContactNumber",
                table: "ProductionCrews");

            migrationBuilder.AddColumn<bool>(
                name: "IsFullRun",
                table: "ProductionCrews",
                type: "bit",
                nullable: false,
                defaultValue: false);
        }
    }
}
