using Apollo.Models;

public interface IMaintenanceService
{
    Task<bool> VerifyPasscode(string passcode);
    Task SubmitPublicSnag(MaintenanceIssue issue, string attemptedPasscode, Stream? fileStream = null, string? fileName = null);
    Task<List<MaintenanceIssue>> GetPendingSnags();
    Task<List<MaintenanceIssue>> GetAllIssuesAsync();
    Task UpdateSnagStatus(int id, SnagStatus newStatus, string? adminNotes = null, string? assignedTo = null, string? contractor = null, string? quote = null, string? description = null);

    // NEW METHODS FOR TICKETING & PARTS
    Task AddNoteAsync(int issueId, string noteText, string? user = "Admin", SnagStatus? statusChange = null);
    Task AddPartAsync(int issueId, string description, int quantity, bool inStock);
    Task TogglePartStatusAsync(int partId, bool inStock, bool isOrdered);
    
    Task SubmitInternalSnagAsync(MaintenanceIssue issue, string reportedBy, Stream? fileStream = null, string? fileName = null);
}
