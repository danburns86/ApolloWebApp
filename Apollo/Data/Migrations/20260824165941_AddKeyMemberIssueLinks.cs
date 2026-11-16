using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class AddKeyMemberIssueLinks : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "AuthorizedByMemberId",
                table: "CheckoutTransactions",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_CheckoutTransactions_AuthorizedByMemberId",
                table: "CheckoutTransactions",
                column: "AuthorizedByMemberId");

            migrationBuilder.AddForeignKey(
                name: "FK_CheckoutTransactions_Members_AuthorizedByMemberId",
                table: "CheckoutTransactions",
                column: "AuthorizedByMemberId",
                principalTable: "Members",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CheckoutTransactions_Members_AuthorizedByMemberId",
                table: "CheckoutTransactions");

            migrationBuilder.DropIndex(
                name: "IX_CheckoutTransactions_AuthorizedByMemberId",
                table: "CheckoutTransactions");

            migrationBuilder.DropColumn(
                name: "AuthorizedByMemberId",
                table: "CheckoutTransactions");
        }
    }
}
