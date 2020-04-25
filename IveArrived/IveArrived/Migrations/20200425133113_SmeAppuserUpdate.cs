using Microsoft.EntityFrameworkCore.Migrations;

namespace IveArrived.Migrations
{
    public partial class SmeAppuserUpdate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "FlierUrlsInternal",
                table: "AspNetUsers");

            migrationBuilder.AddColumn<string>(
                name: "FlierUrl",
                table: "AspNetUsers",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "FlierUrl",
                table: "AspNetUsers");

            migrationBuilder.AddColumn<string>(
                name: "FlierUrlsInternal",
                table: "AspNetUsers",
                type: "nvarchar(max)",
                nullable: true);
        }
    }
}
