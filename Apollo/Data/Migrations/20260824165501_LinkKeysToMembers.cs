using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Apollo.Migrations
{
    /// <inheritdoc />
    public partial class LinkKeysToMembers : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "IssuedToMemberId",
                table: "Keys",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "IssuedToMemberId",
                table: "CheckoutTransactions",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "IssuedToMemberId",
                table: "Bunches",
                type: "int",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Keys_IssuedToMemberId",
                table: "Keys",
                column: "IssuedToMemberId");

            migrationBuilder.CreateIndex(
                name: "IX_CheckoutTransactions_IssuedToMemberId",
                table: "CheckoutTransactions",
                column: "IssuedToMemberId");

            migrationBuilder.CreateIndex(
                name: "IX_Bunches_IssuedToMemberId",
                table: "Bunches",
                column: "IssuedToMemberId");

            migrationBuilder.AddForeignKey(
                name: "FK_Bunches_Members_IssuedToMemberId",
                table: "Bunches",
                column: "IssuedToMemberId",
                principalTable: "Members",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_CheckoutTransactions_Members_IssuedToMemberId",
                table: "CheckoutTransactions",
                column: "IssuedToMemberId",
                principalTable: "Members",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Keys_Members_IssuedToMemberId",
                table: "Keys",
                column: "IssuedToMemberId",
                principalTable: "Members",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Bunches_Members_IssuedToMemberId",
                table: "Bunches");

            migrationBuilder.DropForeignKey(
                name: "FK_CheckoutTransactions_Members_IssuedToMemberId",
                table: "CheckoutTransactions");

            migrationBuilder.DropForeignKey(
                name: "FK_Keys_Members_IssuedToMemberId",
                table: "Keys");

            migrationBuilder.DropIndex(
                name: "IX_Keys_IssuedToMemberId",
                table: "Keys");

            migrationBuilder.DropIndex(
                name: "IX_CheckoutTransactions_IssuedToMemberId",
                table: "CheckoutTransactions");

            migrationBuilder.DropIndex(
                name: "IX_Bunches_IssuedToMemberId",
                table: "Bunches");

            migrationBuilder.DropColumn(
                name: "IssuedToMemberId",
                table: "Keys");

            migrationBuilder.DropColumn(
                name: "IssuedToMemberId",
                table: "CheckoutTransactions");

            migrationBuilder.DropColumn(
                name: "IssuedToMemberId",
                table: "Bunches");
        }
    }
}
