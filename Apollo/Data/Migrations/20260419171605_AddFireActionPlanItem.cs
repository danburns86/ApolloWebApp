using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddFireActionPlanItem : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsResolved",
                table: "FireActionPlanItems",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "ResolutionNotes",
                table: "FireActionPlanItems",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ResolvedBy",
                table: "FireActionPlanItems",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "ResolvedDate",
                table: "FireActionPlanItems",
                type: "datetime2",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsResolved",
                table: "FireActionPlanItems");

            migrationBuilder.DropColumn(
                name: "ResolutionNotes",
                table: "FireActionPlanItems");

            migrationBuilder.DropColumn(
                name: "ResolvedBy",
                table: "FireActionPlanItems");

            migrationBuilder.DropColumn(
                name: "ResolvedDate",
                table: "FireActionPlanItems");
        }
    }
}
