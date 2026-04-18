using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddProductionHub : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "ProductionRoles",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Category = table.Column<int>(type: "int", nullable: false),
                    IsMandatory = table.Column<bool>(type: "bit", nullable: false),
                    LinkedKeyBunchId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductionRoles", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Productions",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Type = table.Column<int>(type: "int", nullable: false),
                    StartDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    EndDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    TicketSourceId = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    HirerName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    HirerContact = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    AccessTime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    TechRequirements = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    RequiresProjection = table.Column<bool>(type: "bit", nullable: false),
                    OurCrew = table.Column<bool>(type: "bit", nullable: false),
                    UnlockingMemberId = table.Column<int>(type: "int", nullable: true),
                    LockingMemberId = table.Column<int>(type: "int", nullable: true),
                    InternalNotes = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DriveLink = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Productions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Productions_Members_LockingMemberId",
                        column: x => x.LockingMemberId,
                        principalTable: "Members",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_Productions_Members_UnlockingMemberId",
                        column: x => x.UnlockingMemberId,
                        principalTable: "Members",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateTable(
                name: "ProductionCredits",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProductionId = table.Column<int>(type: "int", nullable: false),
                    Label = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Value = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DisplayOrder = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductionCredits", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductionCredits_Productions_ProductionId",
                        column: x => x.ProductionId,
                        principalTable: "Productions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "ProductionCrews",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProductionId = table.Column<int>(type: "int", nullable: false),
                    RoleId = table.Column<int>(type: "int", nullable: false),
                    MemberId = table.Column<int>(type: "int", nullable: true),
                    ExternalName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    IsFullRun = table.Column<bool>(type: "bit", nullable: false),
                    RotaNotes = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductionCrews", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductionCrews_Members_MemberId",
                        column: x => x.MemberId,
                        principalTable: "Members",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_ProductionCrews_ProductionRoles_RoleId",
                        column: x => x.RoleId,
                        principalTable: "ProductionRoles",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_ProductionCrews_Productions_ProductionId",
                        column: x => x.ProductionId,
                        principalTable: "Productions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProductionCredits_ProductionId",
                table: "ProductionCredits",
                column: "ProductionId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductionCrews_MemberId",
                table: "ProductionCrews",
                column: "MemberId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductionCrews_ProductionId",
                table: "ProductionCrews",
                column: "ProductionId");

            migrationBuilder.CreateIndex(
                name: "IX_ProductionCrews_RoleId",
                table: "ProductionCrews",
                column: "RoleId");

            migrationBuilder.CreateIndex(
                name: "IX_Productions_LockingMemberId",
                table: "Productions",
                column: "LockingMemberId");

            migrationBuilder.CreateIndex(
                name: "IX_Productions_UnlockingMemberId",
                table: "Productions",
                column: "UnlockingMemberId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "ProductionCredits");

            migrationBuilder.DropTable(
                name: "ProductionCrews");

            migrationBuilder.DropTable(
                name: "ProductionRoles");

            migrationBuilder.DropTable(
                name: "Productions");
        }
    }
}
