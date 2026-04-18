using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class ProductionDetails : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProductionCrews_ProductionRoles_RoleId",
                table: "ProductionCrews");

            migrationBuilder.RenameColumn(
                name: "RotaNotes",
                table: "ProductionCrews",
                newName: "CustomRoleName");

            migrationBuilder.AlterColumn<int>(
                name: "RoleId",
                table: "ProductionCrews",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.CreateTable(
                name: "ProductionEventTypes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductionEventTypes", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "ProductionEvents",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProductionId = table.Column<int>(type: "int", nullable: false),
                    EventTypeId = table.Column<int>(type: "int", nullable: false),
                    EventDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Notes = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductionEvents", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductionEvents_ProductionEventTypes_EventTypeId",
                        column: x => x.EventTypeId,
                        principalTable: "ProductionEventTypes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProductionEvents_EventTypeId",
                table: "ProductionEvents",
                column: "EventTypeId");

            migrationBuilder.AddForeignKey(
                name: "FK_ProductionCrews_ProductionRoles_RoleId",
                table: "ProductionCrews",
                column: "RoleId",
                principalTable: "ProductionRoles",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProductionCrews_ProductionRoles_RoleId",
                table: "ProductionCrews");

            migrationBuilder.DropTable(
                name: "ProductionEvents");

            migrationBuilder.DropTable(
                name: "ProductionEventTypes");

            migrationBuilder.RenameColumn(
                name: "CustomRoleName",
                table: "ProductionCrews",
                newName: "RotaNotes");

            migrationBuilder.AlterColumn<int>(
                name: "RoleId",
                table: "ProductionCrews",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_ProductionCrews_ProductionRoles_RoleId",
                table: "ProductionCrews",
                column: "RoleId",
                principalTable: "ProductionRoles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
