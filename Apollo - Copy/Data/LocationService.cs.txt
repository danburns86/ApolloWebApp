using Apollo.Models;
using Microsoft.EntityFrameworkCore;

namespace Apollo.Data;

public interface ILocationService
{
    Task<List<Area>> GetAreasWithRoomsAsync();
    Task<Area?> GetAreaByIdAsync(int id);
    Task UpsertAreaAsync(Area area);
    Task DeleteAreaAsync(int id);

    Task<Room?> GetRoomByIdAsync(int id);
    Task UpsertRoomAsync(Room room);
    Task DeleteRoomAsync(int id);
}

public class LocationService : ILocationService
{
    private readonly IDbContextFactory<ApplicationDbContext> _dbFactory;

    public LocationService(IDbContextFactory<ApplicationDbContext> dbFactory)
    {
        _dbFactory = dbFactory;
    }

    public async Task<List<Area>> GetAreasWithRoomsAsync()
    {
        using var context = _dbFactory.CreateDbContext();
        return await context.Areas
            .Include(a => a.Rooms)
            .OrderBy(a => a.Name)
            .ToListAsync();
    }

    public async Task<Area?> GetAreaByIdAsync(int id)
    {
        using var context = _dbFactory.CreateDbContext();
        return await context.Areas.Include(a => a.Rooms).FirstOrDefaultAsync(a => a.Id == id);
    }

    public async Task UpsertAreaAsync(Area area)
    {
        using var context = _dbFactory.CreateDbContext();
        if (area.Id == 0) context.Areas.Add(area);
        else context.Areas.Update(area);
        await context.SaveChangesAsync();
    }

    public async Task DeleteAreaAsync(int id)
    {
        using var context = _dbFactory.CreateDbContext();
        var area = await context.Areas.FindAsync(id);
        if (area != null)
        {
            context.Areas.Remove(area);
            await context.SaveChangesAsync();
        }
    }

    public async Task<Room?> GetRoomByIdAsync(int id)
    {
        using var context = _dbFactory.CreateDbContext();
        return await context.Rooms.Include(r => r.Area).FirstOrDefaultAsync(r => r.Id == id);
    }

    public async Task UpsertRoomAsync(Room room)
    {
        using var context = _dbFactory.CreateDbContext();
        if (room.Id == 0) context.Rooms.Add(room);
        else context.Rooms.Update(room);
        await context.SaveChangesAsync();
    }

    public async Task DeleteRoomAsync(int id)
    {
        using var context = _dbFactory.CreateDbContext();
        var room = await context.Rooms.FindAsync(id);
        if (room != null)
        {
            context.Rooms.Remove(room);
            await context.SaveChangesAsync();
        }
    }
}