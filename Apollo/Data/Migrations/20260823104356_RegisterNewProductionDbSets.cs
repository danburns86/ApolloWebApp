using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class RegisterNewProductionDbSets : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ContentWarningTypes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    IconClass = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ShowOnFoHReport = table.Column<bool>(type: "bit", nullable: false),
                    IsEnabled = table.Column<bool>(type: "bit", nullable: false),
                    SortOrder = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ContentWarningTypes", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "ProductionUnavailabilities",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProductionId = table.Column<int>(type: "int", nullable: false),
                    MemberId = table.Column<int>(type: "int", nullable: false),
                    StartDateTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    EndDateTime = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Reason = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductionUnavailabilities", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductionUnavailabilities_Members_MemberId",
                        column: x => x.MemberId,
                        principalTable: "Members",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ProductionUnavailabilities_Productions_ProductionId",
                        column: x => x.ProductionId,
                        principalTable: "Productions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ProductionContentWarnings",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProductionId = table.Column<int>(type: "int", nullable: false),
                    WarningTypeId = table.Column<int>(type: "int", nullable: false),
                    IsActiveForShow = table.Column<bool>(type: "bit", nullable: false),
                    SpecificNotes = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductionContentWarnings", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductionContentWarnings_ContentWarningTypes_WarningTypeId",
                        column: x => x.WarningTypeId,
                        principalTable: "ContentWarningTypes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ProductionContentWarnings_Productions_ProductionId",
                        column: x => x.ProductionId,
                        principalTable: "Productions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProductionContentWarnings_ProductionId",
                table: "ProductionContentWarnings",
                column: "ProductionId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductionContentWarnings_WarningTypeId",
                table: "ProductionContentWarnings",
                column: "WarningTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductionUnavailabilities_MemberId",
                table: "ProductionUnavailabilities",
                column: "MemberId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductionUnavailabilities_ProductionId",
                table: "ProductionUnavailabilities",
                column: "ProductionId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ProductionContentWarnings");

            migrationBuilder.DropTable(
                name: "ProductionUnavailabilities");

            migrationBuilder.DropTable(
                name: "ContentWarningTypes");
        }
    }
}
