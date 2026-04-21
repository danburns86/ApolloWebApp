using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Apollo.Models;
using System.Threading;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Linq;
using System;

namespace Apollo.Data
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        private readonly IHttpContextAccessor? _httpContextAccessor;

        public ApplicationDbContext(
            DbContextOptions<ApplicationDbContext> options,
            IHttpContextAccessor? httpContextAccessor)
            : base(options)
        {
            _httpContextAccessor = httpContextAccessor;
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            // This ensures all the Identity table mapping (AspNetUsers, AspNetRoles, etc.) is included.

            builder.Entity<RAHazard>()
        .HasOne(h => h.RiskAssessment)
        .WithMany(ra => ra.Hazards)
        .HasForeignKey(h => h.RiskAssessmentId)
        .OnDelete(DeleteBehavior.Cascade);
        }

        // --- KEY MANAGEMENT ---
        public DbSet<FormFactor> FormFactors { get; set; }
        public DbSet<Signatory> Signatories { get; set; }
        public DbSet<HardwareLock> Locks { get; set; } // Matches your list
        public DbSet<KeyRecord> Keys { get; set; }         // Matches your list
        public DbSet<Bunch> Bunches { get; set; }
        public DbSet<KeyBunchAssignment> KeyBunchAssignments { get; set; }
        public DbSet<CheckoutTransaction> CheckoutTransactions { get; set; }
        public DbSet<StorageLocation> StorageLocations { get; set; }
        public DbSet<AuditCampaign> AuditCampaigns { get; set; }

        public DbSet<Supplier> Suppliers { get; set; }

        // --- SYSTEM & CONFIG ---
        public DbSet<PortalConfiguration> PortalConfigurations { get; set; }
        public DbSet<Department> Departments { get; set; }
        public DbSet<SystemPermission> SystemPermissions { get; set; }
        public DbSet<AuditLog> AuditLogs { get; set; }

        // --- MAINTENANCE ---
        public DbSet<MaintenanceIssue> MaintenanceIssues { get; set; }
        public DbSet<MaintenanceNote> MaintenanceNotes { get; set; }
        public DbSet<MaintenancePart> MaintenanceParts { get; set; }

        // --- INFRASTRUCTURE ---
        public DbSet<Area> Areas { get; set; }
        public DbSet<Room> Rooms { get; set; }

        // --- ASSETS & COMPLIANCE ---
        public DbSet<AssetCategory> AssetCategories { get; set; }
        public DbSet<Asset> Assets { get; set; }
        public DbSet<InspectionLog> InspectionLogs { get; set; }    // Legacy Logs
        public DbSet<InspectionRecord> InspectionRecords { get; set; } // New Detailed Records

   
        // Personnel & Members
        public DbSet<Member> Members { get; set; }

        // Production Hub - Core
        public DbSet<Production> Productions { get; set; }
        public DbSet<ProductionCategory> ProductionCategories { get; set; }
        public DbSet<ProductionRole> ProductionRoles { get; set; }
        public DbSet<ProductionCrew> ProductionCrews { get; set; }

        // Production Hub - Scheduling & Credits
        public DbSet<ProductionEventType> ProductionEventTypes { get; set; }
        public DbSet<ProductionEvent> ProductionEvents { get; set; }
        public DbSet<ProductionCredit> ProductionCredits { get; set; }

        public DbSet<Performance> Performances { get; set; }

        public DbSet<PerformanceCrewOverride> PerformanceCrewOverrides { get; set; }

        // --- HEALTH & SAFETY ---
        public DbSet<FireSystemComponent> FireSystemComponents { get; set; }
        public DbSet<CoshhSubstance> CoshhSubstances { get; set; }
        public DbSet<RiskAssessment> RiskAssessments { get; set; }
        public DbSet<RAHazard> RAHazards { get; set; }
        public DbSet<IncidentRecord> IncidentRecords { get; set; }

        public DbSet<RiskAssessmentReview> RiskAssessmentReviews { get; set; }
        public DbSet<CoshhAssessment> CoshhAssessments { get; set; }
        public DbSet<FireRiskAssessmentDetails> FireRiskAssessmentDetails { get; set; }

        // --- HEALTH & SAFETY EXTENSIONS ---
        public DbSet<FireRiskAssessment> FireRiskAssessments { get; set; } // Inherited TPH
        public DbSet<FireActionPlanItem> FireActionPlanItems { get; set; }
        public DbSet<RoomFireSafetyAssignment> RoomFireSafetyAssignments { get; set; }

          public DbSet<IncidentEvidence> IncidentEvidence { get; set; }
        public DbSet<ContractorRAMS> ContractorRAMS { get; set; }
        public DbSet<ComplianceConfiguration> ComplianceConfigurations { get; set; }




        // --- THE AUTOMATIC AUDIT LISTENER ---
        // --- THE AUTOMATIC AUDIT LISTENER ---
        public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            var currentUser = _httpContextAccessor?.HttpContext?.User?.Identity?.Name ?? "System";
            var auditEntries = new List<AuditLog>();

            foreach (var entry in ChangeTracker.Entries())
            {
                if (entry.Entity is AuditLog || entry.State == EntityState.Detached || entry.State == EntityState.Unchanged)
                    continue;

                var auditEntry = new AuditLog
                {
                    Timestamp = DateTime.Now,
                    UserId = currentUser
                };

                // 1. Make the Table Name Human-Readable
                string entityName = entry.Entity.GetType().Name;
                if (entityName.Contains("Proxy")) entityName = entry.Entity.GetType().BaseType?.Name ?? entityName; // Handle EF Core Proxies

                auditEntry.TableName = entry.Entity switch
                {
                    KeyBunchAssignment => "Bunch Assignment",
                    CheckoutTransaction => "Checkout / Return Record",
                    KeyRecord => "Key Inventory",
                    HardwareLock => "Hardware Lock",
                    AuditCampaign => "Physical Audit Campaign",
                    PortalConfiguration => "System Settings",
                    AssetCategory => "Asset Category",         // ADDED
                    Asset => "Asset & Equipment",              // ADDED
                    InspectionLog => "Safety Inspection",      // ADDED
                    FireSystemComponent => "Fire Safety Hardware",
                    CoshhSubstance => "COSHH Registry",
                    CoshhAssessment => "COSHH Assessment", 
                    FireRiskAssessment => "Fire Safety Audit",
                    RiskAssessment => "Risk Assessment",
                    RAHazard => "RA Hazard Detail",
                    IncidentRecord => "Accident / Incident Log",
                    FireActionPlanItem => "Fire Action Plan",
                    RiskAssessmentReview => "RA Periodic Review",
                    
                    _ => entityName
                   
                };

                // 2. Fix the Negative ID Bug
                var primaryKey = entry.Properties.FirstOrDefault(p => p.Metadata.IsPrimaryKey());
                if (entry.State == EntityState.Added)
                {
                    // EF Core uses negative numbers (-2147482647) before saving to the DB.
                    auditEntry.PrimaryKey = "New Record";
                }
                else
                {
                    auditEntry.PrimaryKey = primaryKey?.CurrentValue?.ToString() ?? "Unknown";
                }

                // 3. Make the Actions Human-Readable
                auditEntry.ActionType = entry.State switch
                {
                    EntityState.Added => "Created",
                    EntityState.Modified => "Updated",
                    EntityState.Deleted => "Deleted",
                    _ => entry.State.ToString()
                };

                // 4. Context-Aware Action Overrides (The magic touch)
                if (entry.Entity is CheckoutTransaction tx)
                {
                    if (entry.State == EntityState.Added) auditEntry.ActionType = "Item Issued";
                    else if (entry.State == EntityState.Modified && entry.Property("ReturnDate").IsModified) auditEntry.ActionType = "Item Returned";
                }
                else if (entry.Entity is KeyBunchAssignment)
                {
                    if (entry.State == EntityState.Added) auditEntry.ActionType = "Clipped to Bunch";
                    else if (entry.State == EntityState.Modified && entry.Property("RemovedDate").IsModified) auditEntry.ActionType = "Removed from Bunch";
                }
                else if (entry.Entity is KeyRecord)
                {
                    if (entry.State == EntityState.Modified && entry.Property("Status").IsModified)
                    {
                        var newStatus = entry.Property("Status").CurrentValue?.ToString();
                        if (newStatus == "Lost") auditEntry.ActionType = "Marked as Lost";
                        if (newStatus == "Damaged") auditEntry.ActionType = "Marked as Damaged";
                    }
                }

                // 5. Serialize the Data changes for the "View JSON" modal
                if (entry.State == EntityState.Added)
                {
                    auditEntry.NewValues = System.Text.Json.JsonSerializer.Serialize(
                        entry.Properties.Where(p => !p.Metadata.IsPrimaryKey()).ToDictionary(p => p.Metadata.Name, p => p.CurrentValue)
                    );
                }
                else if (entry.State == EntityState.Deleted)
                {
                    auditEntry.OldValues = System.Text.Json.JsonSerializer.Serialize(
                        entry.Properties.ToDictionary(p => p.Metadata.Name, p => p.OriginalValue)
                    );
                }
                else if (entry.State == EntityState.Modified)
                {
                    var oldValues = new Dictionary<string, object?>();
                    var newValues = new Dictionary<string, object?>();

                    foreach (var property in entry.Properties)
                    {
                        if (property.IsModified)
                        {
                            oldValues[property.Metadata.Name] = property.OriginalValue;
                            newValues[property.Metadata.Name] = property.CurrentValue;
                        }
                    }
                    auditEntry.OldValues = System.Text.Json.JsonSerializer.Serialize(oldValues);
                    auditEntry.NewValues = System.Text.Json.JsonSerializer.Serialize(newValues);
                }

                auditEntries.Add(auditEntry);
            }

            if (auditEntries.Any())
            {
                AuditLogs.AddRange(auditEntries);
            }

            return await base.SaveChangesAsync(cancellationToken);
        }
    }
}