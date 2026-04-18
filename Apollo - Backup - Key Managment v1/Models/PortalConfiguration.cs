using System.ComponentModel.DataAnnotations;

namespace Apollo.Models
{
    public class PortalConfiguration
    {
        public int Id { get; set; }

        [Required, StringLength(100)]
        public string TheatreName { get; set; } = "Apollo";

        [StringLength(255)]
        public string LogoUrl { get; set; } = "/images/default-logo.png";

        [StringLength(255)]
        public string FaviconUrl { get; set; } = "/favicon.png"; // <-- Added Favicon

        [Range(1, 720)]
        public int StaleCheckoutHours { get; set; } = 48;

        // Add this inside the PortalConfiguration class
        public string? CustomLinksJson { get; set; } = "[]";
    }

    public class TopBarLink
{
    public string Title { get; set; } = string.Empty;
    public string Url { get; set; } = string.Empty;
    public string IconClass { get; set; } = "bi-link-45deg";
}



}