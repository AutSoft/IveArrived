using Microsoft.EntityFrameworkCore.Migrations;

namespace IveArrived.Migrations
{
    public partial class DeliveryUpdate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "City",
                table: "Delivery",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Country",
                table: "Delivery",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ZipCode",
                table: "Delivery",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "City",
                table: "Delivery");

            migrationBuilder.DropColumn(
                name: "Country",
                table: "Delivery");

            migrationBuilder.DropColumn(
                name: "ZipCode",
                table: "Delivery");
        }
    }
}
