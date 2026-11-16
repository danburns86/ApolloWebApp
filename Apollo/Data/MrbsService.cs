using Apollo.Models;

namespace Apollo.Data
{
    public interface IMrbsService
    {
        Task<List<CalendarEventItem>> GetBookingsAsync(DateTime start, DateTime end);
    }

    public class MrbsService : IMrbsService
    {
        public Task<List<CalendarEventItem>> GetBookingsAsync(DateTime start, DateTime end)
        {
            // Placeholder returning an empty list until MRBS DB connection settings are attached
            var items = new List<CalendarEventItem>();
            return Task.FromResult(items);
        }
    }
}