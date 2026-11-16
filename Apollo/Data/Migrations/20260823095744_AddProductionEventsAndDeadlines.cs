using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddProductionEventsAndDeadlines : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProductionEvents_ProductionEventTypes_EventTypeId",
                table: "ProductionEvents");

            migrationBuilder.RenameColumn(
                name: "EventDate",
                table: "ProductionEvents",
                newName: "StartTime");

            migrationBuilder.AlterColumn<string>(
                name: "Notes",
                table: "ProductionEvents",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "EventTypeId",
                table: "ProductionEvents",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddColumn<DateTime>(
                name: "EndTime",
                table: "ProductionEvents",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<bool>(
                name: "IsCastNotRequired",
                table: "ProductionEvents",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<bool>(
                name: "IsTechnicalDate",
                table: "ProductionEvents",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "Location",
                table: "ProductionEvents",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "SectionCovered",
                table: "ProductionEvents",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<bool>(
                name: "ShowOnSchedule",
                table: "ProductionEvents",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.CreateTable(
                name: "ProductionDeadlines",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ProductionId = table.Column<int>(type: "int", nullable: false),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DueDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    IsCompleted = table.Column<bool>(type: "bit", nullable: false),
                    ShowOnSchedule = table.Column<bool>(type: "bit", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ProductionDeadlines", x => x.Id);
                    table.ForeignKey(
                        name: "FK_ProductionDeadlines_Productions_ProductionId",
                        column: x => x.ProductionId,
                        principalTable: "Productions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_ProductionDeadlines_ProductionId",
                table: "ProductionDeadlines",
                column: "ProductionId");

            migrationBuilder.AddForeignKey(
                name: "FK_ProductionEvents_ProductionEventTypes_EventTypeId",
                table: "ProductionEvents",
                column: "EventTypeId",
                principalTable: "ProductionEventTypes",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_ProductionEvents_ProductionEventTypes_EventTypeId",
                table: "ProductionEvents");

            migrationBuilder.DropTable(
                name: "ProductionDeadlines");

            migrationBuilder.DropColumn(
                name: "EndTime",
                table: "ProductionEvents");

            migrationBuilder.DropColumn(
                name: "IsCastNotRequired",
                table: "ProductionEvents");

            migrationBuilder.DropColumn(
                name: "IsTechnicalDate",
                table: "ProductionEvents");

            migrationBuilder.DropColumn(
                name: "Location",
                table: "ProductionEvents");

            migrationBuilder.DropColumn(
                name: "SectionCovered",
                table: "ProductionEvents");

            migrationBuilder.DropColumn(
                name: "ShowOnSchedule",
                table: "ProductionEvents");

            migrationBuilder.RenameColumn(
                name: "StartTime",
                table: "ProductionEvents",
                newName: "EventDate");

            migrationBuilder.AlterColumn<string>(
                name: "Notes",
                table: "ProductionEvents",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<int>(
                name: "EventTypeId",
                table: "ProductionEvents",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_ProductionEvents_ProductionEventTypes_EventTypeId",
                table: "ProductionEvents",
                column: "EventTypeId",
                principalTable: "ProductionEventTypes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
