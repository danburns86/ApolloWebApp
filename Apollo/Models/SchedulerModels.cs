namespace Apollo.Models
{
    public enum CalendarEventCategory
    {
        Show,
        RehearsalMeeting,
        SafetyReview,
        Maintenance,
        MrbsBooking
    }

    public class CalendarEventItem
    {
        public string Id { get; set; } = string.Empty;
        public string Title { get; set; } = string.Empty;
        public DateTime Date { get; set; }
        public string TimeDisplay { get; set; } = "All Day";
        public CalendarEventCategory Category { get; set; }
        public string CategoryDisplay { get; set; } = string.Empty;
        public string Location { get; set; } = string.Empty;
        public string BadgeClass { get; set; } = "bg-secondary text-white";
        public string BorderClass { get; set; } = "border-secondary";
        public string IconClass { get; set; } = "bi bi-calendar-event";
        public string Description { get; set; } = string.Empty;
        public string TargetUrl { get; set; } = string.Empty;
    }
}