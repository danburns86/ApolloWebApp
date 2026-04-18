using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddAuditCampaignsTable : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "LastAuditCampaignId",
                table: "Keys",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "AuditCampaigns",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AuditCampaigns", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Keys_LastAuditCampaignId",
                table: "Keys",
                column: "LastAuditCampaignId");

            migrationBuilder.AddForeignKey(
                name: "FK_Keys_AuditCampaigns_LastAuditCampaignId",
                table: "Keys",
                column: "LastAuditCampaignId",
                principalTable: "AuditCampaigns",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Keys_AuditCampaigns_LastAuditCampaignId",
                table: "Keys");

            migrationBuilder.DropTable(
                name: "AuditCampaigns");

            migrationBuilder.DropIndex(
                name: "IX_Keys_LastAuditCampaignId",
                table: "Keys");

            migrationBuilder.DropColumn(
                name: "LastAuditCampaignId",
                table: "Keys");
        }
    }
}
