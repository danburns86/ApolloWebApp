using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Apollo.Models
{
    #region ENUMS
    public enum SnagStatus { Pending, Approved, InProgress, PartsRequired, ContractorRequired, Resolved, Deferred }
    public enum SnagSeverity { Low, Medium, High, Emergency }
    public enum SnagType { Building, Equipment }
    public enum AssetStatus { Active, InStorage, Decommissioned, OutForRepair, Quarantined }
    public enum EquipmentClass { ClassI, ClassII, IT, Battery }
    public enum EnvironmentRisk { Low, Medium, High }
    public enum InspectionType { PAT, LOLER, Visual, FireExit, Rigging }
    public enum InspectionResult { Pass, Fail, Advisory }
    public enum FormFactorEnum { Mortice, Euro, Rim, Padlock, Cabinet, Other }
    #endregion

    #region INFRASTRUCTURE
    public class Area
    {
        [Key]
        public int Id { get; set; }
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty;
        public string? Description { get; set; }
        public ICollection<Room> Rooms { get; set; } = new List<Room>();
    }

    public class Room
    {
        [Key]
        public int Id { get; set; }
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty;

        public int AreaId { get; set; }
        [ForeignKey("AreaId")]
        public Area? Area { get; set; }

        public string? NearestExit { get; set; }
        public string? AlternativeExit { get; set; }
        public string? CallPoints { get; set; }
        public string? FireActionNotes { get; set; }

        public int? MRBSRoomId { get; set; }
        public bool IsPublic { get; set; }
        public bool IsActive { get; set; } = true;

        public EnvironmentRisk DefaultRisk { get; set; } = EnvironmentRisk.Medium;
        public ICollection<Asset> Assets { get; set; } = new List<Asset>();
        public ICollection<MaintenanceIssue> MaintenanceIssues { get; set; } = new List<MaintenanceIssue>();
    }

    public class StorageLocation
    {
        [Key]
        public int Id { get; set; }
        public bool IsActive { get; set; } = true;
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty;
    }

    public class Department
    {
        [Key]
        public int Id { get; set; }
        public bool IsActive { get; set; } = true;
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty;
    }
    #endregion

    #region CONFIGURATION
    public class PortalConfiguration
    {
        [Key]
        public int Id { get; set; }

        [StringLength(100)]
        public string TheatreName { get; set; } = "Apollo";

        [StringLength(100)]
        public string WelcomeHeading { get; set; } = "Welcome to the Portal";

        [StringLength(250)]
        public string WelcomeMessage { get; set; } = "Select a management module below to begin.";

        public string? NavbarLogoUrl { get; set; }
        public string? FaviconUrl { get; set; }

        [Range(1, 720)]
        public int StaleCheckoutHours { get; set; } = 48;

        public string? CustomLinksJson { get; set; } = "[]";

        public bool IsKeyManagementEnabled { get; set; } = true;
        public bool IsReportsEnabled { get; set; } = true;
        public bool IsAdminEnabled { get; set; } = true;
        public bool IsRoomBookingsEnabled { get; set; } = true;
        public bool IsBoxOfficeEnabled { get; set; } = true;
        public bool IsAssetsEnabled { get; set; } = true;
        public bool IsMaintenanceEnabled { get; set; } = true;

        [StringLength(20)]
        public string StageDoorPasscode { get; set; } = "1234";
    }

    public class TopBarLink
    {
        [Key]
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public string Url { get; set; } = string.Empty;
        public string IconClass { get; set; } = "bi-link-45deg";
    }

    public class SystemPermission
    {
        [Key]
        public int Id { get; set; }
        [Required]
        [StringLength(50)]
        public string Module { get; set; } = string.Empty;
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty;
        [Required]
        [StringLength(100)]
        public string ClaimValue { get; set; } = string.Empty;
    }
    #endregion

    #region ASSET TRACKING & COMPLIANCE
    public class AssetCategory
    {
        [Key]
        public int Id { get; set; }
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty;
        [Required]
        [StringLength(10)]
        public string Prefix { get; set; } = string.Empty;

        public int NextSequenceNumber { get; set; } = 1;
        public int PaddingLength { get; set; } = 4;
        public bool IsActive { get; set; } = true;

        public ICollection<Asset> Assets { get; set; } = new List<Asset>();
    }

    public class Asset
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(50)]
        public string AssetTag { get; set; } = string.Empty;

        public int CategoryId { get; set; }
        [ForeignKey("CategoryId")]
        public AssetCategory? Category { get; set; }

        [Required]
        [StringLength(150)]
        public string Name { get; set; } = string.Empty;

        public string? Manufacturer { get; set; }
        public string? Model { get; set; }
        public string? SerialNumber { get; set; }

        public int? RoomId { get; set; }
        [ForeignKey("RoomId")]
        public Room? Room { get; set; }

        public AssetStatus Status { get; set; } = AssetStatus.Active;

        [Column(TypeName = "decimal(18,2)")]
        public decimal? ReplacementCost { get; set; }

        public bool IsOffsite { get; set; } = false;
        public string? AssignedTo { get; set; }

        public bool RequiresPAT { get; set; } = false;
        public bool RequiresLOLER { get; set; } = false;
        public bool VisualOnly { get; set; } = false;

        public EquipmentClass? ApplianceClass { get; set; }
        public EnvironmentRisk? RiskOverride { get; set; }
        public int? RetestIntervalOverride { get; set; }
        public DateTime? NextPATDue { get; set; }
        public DateTime? NextLOLERDue { get; set; }

        public ICollection<InspectionRecord> InspectionHistory { get; set; } = new List<InspectionRecord>();
        public ICollection<MaintenanceIssue> MaintenanceIssues { get; set; } = new List<MaintenanceIssue>();

        [NotMapped]
        public string PATStatus => GetCompStatus(RequiresPAT || VisualOnly, NextPATDue);
        [NotMapped]
        public string LOLERStatus => GetCompStatus(RequiresLOLER, NextLOLERDue);

        [StringLength(50)]
        public string? SWL { get; set; } // e.g., "500kg", "1t", "2:1 Factor"
        public DateTime? LastWeightTestDate { get; set; }

        private string GetCompStatus(bool required, DateTime? dueDate)
        {
            if (!required) return "N/A";
            if (Status == AssetStatus.Quarantined) return "FAILED";
            if (dueDate == null) return "OVERDUE";
            var days = (dueDate.Value - DateTime.Now).TotalDays;
            if (days < 0) return "OVERDUE";
            if (days <= 30) return "EXPIRING SOON";
            return "VALID";
        }
    }

    public class SystemCredential
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public string SystemName { get; set; } = string.Empty; // e.g., "Main Fire Panel", "Intruder Alarm"
        public string Category { get; set; } = "Building"; // Building, Security, Box Office
        public string? Description { get; set; }
        public string? AccessCode { get; set; } // For pin codes
        public string? Username { get; set; }
        public string? Password { get; set; }
        public DateTime LastChanged { get; set; } = DateTime.Now;
        public string? LocationDetail { get; set; } // e.g., "Panel in Stage Left Wing"
    }
    public class InspectionRecord
    {
        [Key]
        public int Id { get; set; }
        public int AssetId { get; set; }
        [ForeignKey("AssetId")]
        public Asset? Asset { get; set; }

        public DateTime InspectionDate { get; set; } = DateTime.Now;
        public string InspectedBy { get; set; } = string.Empty;
        public InspectionType Type { get; set; }
        public InspectionResult Status { get; set; }

        [Column(TypeName = "decimal(18, 4)")]
        public decimal? EarthBond { get; set; }
        [Column(TypeName = "decimal(18, 4)")]
        public decimal? Insulation { get; set; }
        [Column(TypeName = "decimal(18, 4)")]
        public decimal? Leakage { get; set; }
        [Column(TypeName = "decimal(18, 4)")]
        public decimal? Load { get; set; }
        public string? Polarity { get; set; }
        public string? Comments { get; set; }

        public bool EarthBondPassed { get; set; }
        public bool InsulationPassed { get; set; }
        public bool LeakagePassed { get; set; }
        public bool PolarityPassed { get; set; }
        public DateTime NextDueDate { get; set; }
        public string? RawTestData { get; set; }

        // --- LOLER / LIFTING METRICS ---
        public bool WeightTestPerformed { get; set; } = false;
        public string? ExaminedComponents { get; set; } // e.g., "Chain, Hook, Brake, Clutch"
    }
    #endregion

    #region MAINTENANCE
    public class MaintenanceIssue
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public int RoomId { get; set; }
        [ForeignKey("RoomId")]
        public Room? Room { get; set; }

        [Required]
        public string Description { get; set; } = string.Empty;
        public SnagType Type { get; set; } = SnagType.Building;
        public int? AssetId { get; set; }
        [ForeignKey("AssetId")]
        public Asset? Asset { get; set; }

        public SnagSeverity Severity { get; set; } = SnagSeverity.Medium;
        public SnagStatus Status { get; set; } = SnagStatus.Pending;
        public string? ReportedByName { get; set; }
        public DateTime ReportedAt { get; set; } = DateTime.Now;
        public string? AdminNotes { get; set; }
        public DateTime? ResolvedAt { get; set; }
        public string? ImagePath { get; set; }
        public string? AssignedTo { get; set; }
        public string? ContractorCompany { get; set; }
        public string? QuoteReference { get; set; }

        public ICollection<MaintenanceNote> Notes { get; set; } = new List<MaintenanceNote>();
        public ICollection<MaintenancePart> Parts { get; set; } = new List<MaintenancePart>();
    }

    public class MaintenanceNote
    {
        [Key]
        public int Id { get; set; }
        public int MaintenanceIssueId { get; set; }
        [ForeignKey("MaintenanceIssueId")]
        public MaintenanceIssue? MaintenanceIssue { get; set; }
        [Required]
        public string NoteText { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public string? CreatedBy { get; set; }
        public SnagStatus? StatusChange { get; set; }
    }

    public class MaintenancePart
    {
        [Key]
        public int Id { get; set; }
        public int MaintenanceIssueId { get; set; }
        [ForeignKey("MaintenanceIssueId")]
        public MaintenanceIssue? MaintenanceIssue { get; set; }
        [Required]
        public string Description { get; set; } = string.Empty;
        public int Quantity { get; set; } = 1;
        public bool InStock { get; set; } = false;
        public bool NeedsOrdering { get; set; } = true;
        public bool IsOrdered { get; set; } = false;
    }
    #endregion

    #region KEY MANAGEMENT
    public class KeyRecord
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public int SequenceNumber { get; set; }
        [Required]
        [StringLength(20)]
        public string Status { get; set; } = "Issued";
        public DateTime? LastSeenDate { get; set; }
        public DateTime? LastFormalAuditDate { get; set; }
        public string? IssuedToName { get; set; }
        public bool IsLostLockout { get; set; } = false;
        public int LockId { get; set; }
        [ForeignKey("LockId")]
        public HardwareLock? Lock { get; set; }
        public int? StorageLocationId { get; set; }
        [ForeignKey("StorageLocationId")]
        public StorageLocation? StorageLocation { get; set; }
        public int? LastAuditCampaignId { get; set; }
        [ForeignKey("LastAuditCampaignId")]
        public AuditCampaign? LastAuditCampaign { get; set; }
        public ICollection<KeyBunchAssignment> BunchAssignments { get; set; } = new List<KeyBunchAssignment>();
    }

    public class Bunch
    {
        [Key]
        public int Id { get; set; }
        public bool IsActive { get; set; } = true;
        public bool IsLost { get; set; } = false;
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty;
        public int? DepartmentId { get; set; }
        [ForeignKey("DepartmentId")]
        public Department? Department { get; set; }
        public int? StorageLocationId { get; set; }
        [ForeignKey("StorageLocationId")]
        public StorageLocation? StorageLocation { get; set; }
        public string? IssuedToName { get; set; }
        public DateTime? IssueDate { get; set; }
        public DateTime? ReturnDate { get; set; }
        public ICollection<KeyBunchAssignment> KeyAssignments { get; set; } = new List<KeyBunchAssignment>();
    }

    public class KeyBunchAssignment
    {
        [Key]
        public int Id { get; set; }
        public int KeyRecordId { get; set; }
        [ForeignKey("KeyRecordId")]
        public KeyRecord? KeyRecord { get; set; }
        public int BunchId { get; set; }
        [ForeignKey("BunchId")]
        public Bunch? Bunch { get; set; }
        public DateTime AssignedDate { get; set; }
        public DateTime? RemovedDate { get; set; }
    }

    public class HardwareLock
    {
        [Key]
        public int Id { get; set; }
        public bool IsActive { get; set; } = true;
        [Required]
        [StringLength(4)]
        public string LockCode { get; set; } = string.Empty;
        public string? KeyCode { get; set; }
        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty;
        public int? SupplierId { get; set; }
        [ForeignKey("SupplierId")]
        public Supplier? Supplier { get; set; }
        public string? Manufacturer { get; set; }
        public string Status { get; set; } = "Active";
        public int FormFactorId { get; set; }
        [ForeignKey("FormFactorId")]
        public FormFactor? FormFactor { get; set; }
        public int? RoomId { get; set; }
        [ForeignKey("RoomId")]
        public Room? Room { get; set; }
        public ICollection<Signatory> Signatories { get; set; } = new List<Signatory>();
        public ICollection<KeyRecord> Keys { get; set; } = new List<KeyRecord>();
    }

    public class FormFactor
    {
        [Key]
        public int Id { get; set; }
        public bool IsActive { get; set; } = true;
        [Required]
        [StringLength(50)]
        public string Name { get; set; } = string.Empty;
        public ICollection<HardwareLock> Locks { get; set; } = new List<HardwareLock>();
    }

    public class Signatory
    {
        [Key]
        public int Id { get; set; }
        public bool IsActive { get; set; } = true;
        [Required]
        public string Name { get; set; } = string.Empty;
        public string? ContactInfo { get; set; }
        public ICollection<HardwareLock> Locks { get; set; } = new List<HardwareLock>();
    }

    public class Supplier
    {
        [Key]
        public int Id { get; set; }
        public bool IsActive { get; set; } = true;
        [Required]
        public string Name { get; set; } = string.Empty;
        public string? Address { get; set; }
        public string? Email { get; set; }
        public string? Phone { get; set; }
        public ICollection<HardwareLock> Locks { get; set; } = new List<HardwareLock>();
    }

    public class CheckoutTransaction
    {
        [Key]
        public int Id { get; set; }
        public int? BunchId { get; set; }
        [ForeignKey("BunchId")]
        public Bunch? Bunch { get; set; }
        public int? KeyRecordId { get; set; }
        [ForeignKey("KeyRecordId")]
        public KeyRecord? KeyRecord { get; set; }
        [Required]
        public string IssuedToName { get; set; } = string.Empty;
        [Required]
        public DateTime IssueDate { get; set; }
        public DateTime? ReturnDate { get; set; }
        public string? AuthorizedByUserName { get; set; }
    }

    public class AuditCampaign
    {
        [Key]
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public DateTime CreatedAt { get; set; } = DateTime.Now;
    }

    public class AuditLog
    {
        [Key]
        public int Id { get; set; }
        public string? UserId { get; set; }
        [Required]
        public string ActionType { get; set; } = string.Empty;
        [Required]
        public string TableName { get; set; } = string.Empty;
        public string PrimaryKey { get; set; } = string.Empty;
        public string? OldValues { get; set; }
        public string? NewValues { get; set; }
        public DateTime Timestamp { get; set; } = DateTime.Now;
    }
    #endregion

    public class InspectionLog
    {
        [Key]
        public int Id { get; set; }
        public int AssetId { get; set; }
        [ForeignKey("AssetId")]
        public Asset? Asset { get; set; }

        [Required]
        [StringLength(50)]
        public string InspectionType { get; set; } = "PAT"; // "PAT", "LOLER", "Visual"

        public DateTime DateTested { get; set; } = DateTime.Now;
        public bool Passed { get; set; } = true;

        public string? TestedBy { get; set; }
        public string? Notes { get; set; }
    }

    public class Member
    {
        public int Id { get; set; }
        public string MemberNumber { get; set; } = string.Empty;
        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string? Email { get; set; }
        public string? MobileNumber { get; set; }
        public string MembershipStatus { get; set; } = "Active"; // Active, Expired, etc.
        public DateTime? ExpiryDate { get; set; }

        // Compliance Flags
        public bool IsFirstAider { get; set; }
        public bool HasDBS { get; set; }

        public bool IsTechTeam { get; set; }

        // Crewing & Technical Skills (Mapped from CSV)
        public bool SkillActing { get; set; }
        public bool SkillDirector { get; set; }
        public bool SkillLXDesign { get; set; }
        public bool SkillLXOp { get; set; }
        public bool SkillSoundDesign { get; set; }
        public bool SkillSoundOp { get; set; }
        public bool SkillStageManager { get; set; }
        public bool SkillStageCrew { get; set; }
        public bool SkillWardrobe { get; set; }
        public bool SkillSetBuild { get; set; }
        public bool SkillFOH { get; set; }
        public bool SkillBar { get; set; }

        public string FullName => $"{FirstName} {LastName}";

        public List<ProductionCrew> CrewingHistory { get; set; } = new();
    }

    public class ProductionCategory
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string IconClass { get; set; } = "bi-star";
        public bool IsExternal { get; set; } // <--- NEW FLAG
    }

    // 2. Manageable Event Types (Technical, Dress Rehearsal, etc.)
    public class ProductionEventType
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
    }

    public class Production
    {
        public int Id { get; set; }
        public string Title { get; set; } = string.Empty;
        public int CategoryId { get; set; }
        public ProductionCategory? Category { get; set; }

        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string? TicketSourceId { get; set; }

        // --- LOGISTICS & HIRE ---
        public string? HirerName { get; set; }
        public string? HirerContact { get; set; }
        public DateTime? AccessTime { get; set; }
        public string? TechRequirements { get; set; }
        public bool OurCrew { get; set; }

        // --- SECURITY (Linking to Members) ---
        public int? UnlockingMemberId { get; set; }
        public Member? UnlockingMember { get; set; }
        public int? LockingMemberId { get; set; }
        public Member? LockingMember { get; set; }

        public string? InternalNotes { get; set; }
        public string? DriveLink { get; set; }

        // --- FOH SPECIFICS ---
        public int RunningTimeMinutes { get; set; }
        public int IntervalMinutes { get; set; }
        public string? ContentWarnings { get; set; }
        public string? FOHNotes { get; set; }

        // --- NAVIGATION ---
        public List<Performance> Performances { get; set; } = new();
        public List<ProductionCrew> CrewAssignments { get; set; } = new();
        public List<ProductionCredit> Credits { get; set; } = new();
        public List<ProductionEvent> Events { get; set; } = new();
    }

    public class Performance
    {
        public int Id { get; set; }
        public int ProductionId { get; set; }

        // THIS LINE FIXES YOUR BUILD ERRORS:
        public Production? Production { get; set; }

        public DateTime CurtainUp { get; set; }
        public string? PerformanceTitle { get; set; }
        public string? ScheduleNotes { get; set; }
        public List<PerformanceCrewOverride> Overrides { get; set; } = new();
    }
    public class ProductionRole
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public int CategoryId { get; set; } // Which category template this belongs to
        public ProductionCategory? Category { get; set; }
        public bool IsMandatory { get; set; }
        public int? LinkedKeyBunchId { get; set; }
    }

    public class ProductionCrew
    {
        public int Id { get; set; }
        public int ProductionId { get; set; }
        public int? RoleId { get; set; }
        public ProductionRole? Role { get; set; }
        public string? CustomRoleName { get; set; } // If RoleId is null
        public bool IsRequired { get; set; }
        public int? MemberId { get; set; }
        public Member? Member { get; set; }
        public string? ExternalName { get; set; }
        public bool IsFullRun { get; set; } = true;

        public Production? Production { get; set; }
    }

    public class ProductionEvent
    {
        public int Id { get; set; }
        public int ProductionId { get; set; }
        public int EventTypeId { get; set; }
        public ProductionEventType? EventType { get; set; }
        public DateTime EventDate { get; set; }
        public string? Notes { get; set; }
    }

    public class ProductionCredit
    {
        public int Id { get; set; }
        public int ProductionId { get; set; }
        public string Label { get; set; } = string.Empty;
        public string Value { get; set; } = string.Empty;
        public int DisplayOrder { get; set; }
    }

    public class PerformanceCrewOverride
    {
        public int Id { get; set; }
        public int PerformanceId { get; set; }

        // Changed to int? to allow nulls for custom roles
        public int? RoleId { get; set; }
        public ProductionRole? Role { get; set; }

        // Added to support one-off role overrides
        public string? CustomRoleName { get; set; }

        public int? MemberId { get; set; }
        public Member? Member { get; set; }
        public string? ExternalName { get; set; }
    }

    #region HEALTH & SAFETY MODULE

    public enum RiskAssessmentType { General, Production, Fire, COSHH }
    public enum IncidentSeverity { NearMiss, Minor, Major, RIDDOR }

    public class FireSystemComponent
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public string UniqueID { get; set; } = string.Empty; // e.g., CP 01, S101, S102

        [Required]
        public string Type { get; set; } = "Smoke Head"; // Smoke Head, Heat, Sounder, Call Point, Em Light
        public bool IsMaintained { get; set; } // For Emergency Lights

        public int RoomId { get; set; }
        [ForeignKey("RoomId")]
        public Room? Room { get; set; }

        public string? SpecificLocation { get; set; } // e.g. "Behind the LX rack"
        public DateTime? LastTested { get; set; }
        public bool IsActive { get; set; } = true;
    }

    public class CoshhSubstance
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public string Name { get; set; } = string.Empty;
        public string? Manufacturer { get; set; }
        public string? MsdsFilePath { get; set; } // Storage path for the PDF
        public DateTime? MsdsExpiry { get; set; }

        public string? HazardPictograms { get; set; } // Store as comma-sep string: "Flammable, Toxic"
        public string? UseInstructions { get; set; }
    }

    public class RiskAssessment
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public string Title { get; set; } = string.Empty;
        public RiskAssessmentType Type { get; set; } = RiskAssessmentType.General;

        public int? ProductionId { get; set; }
        [ForeignKey("ProductionId")]
        public Production? Production { get; set; }

        public int? AreaId { get; set; }
        [ForeignKey("AreaId")]
        public Area? Area { get; set; }

        public string? AssessedBy { get; set; }
        public DateTime AssessmentDate { get; set; } = DateTime.Now;
        public DateTime ReviewDueDate { get; set; } = DateTime.Now.AddYears(1);

        public bool IsApproved { get; set; }
        public string? ApprovedBy { get; set; }

        public ICollection<RAHazard> Hazards { get; set; } = new List<RAHazard>();
    }

    public class RAHazard
    {
        [Key]
        public int Id { get; set; }
        public int RiskAssessmentId { get; set; }
        [ForeignKey("RiskAssessmentId")]
        public RiskAssessment? RiskAssessment { get; set; }

        [Required]
        public string HazardName { get; set; } = string.Empty;
        public string? WhoIsAtRisk { get; set; }

        public int InitialLikelihood { get; set; } // 1-5
        public int InitialSeverity { get; set; }   // 1-5

        public string? MitigationMeasures { get; set; }

        public int ResidualLikelihood { get; set; } // 1-5
        public int ResidualSeverity { get; set; }   // 1-5
    }

    public class IncidentRecord
    {
        [Key]
        public int Id { get; set; }
        public DateTime Timestamp { get; set; } = DateTime.Now;
        public IncidentSeverity Severity { get; set; } = IncidentSeverity.Minor;

        [Required]
        public string Description { get; set; } = string.Empty;
        public string? PersonsInvolved { get; set; }
        public string? TreatmentGiven { get; set; }

        public int? RoomId { get; set; }
        [ForeignKey("RoomId")]
        public Room? Room { get; set; }

        public bool IsRiddorReportable { get; set; }
        public DateTime? RiddorReportedDate { get; set; }
    }

    // --- Add to H&S Region ---

    public class RiskAssessmentReview
    {
        [Key]
        public int Id { get; set; }
        public int RiskAssessmentId { get; set; }
        [ForeignKey("RiskAssessmentId")]
        public RiskAssessment? RiskAssessment { get; set; }

        public DateTime ReviewDate { get; set; } = DateTime.Now;
        public string ReviewedBy { get; set; } = string.Empty;
        public string ReviewOutcome { get; set; } = "No Changes Required"; // or "Updated Hazards"
        public string? Comments { get; set; }
        public DateTime NextReviewDueDate { get; set; }
    }

    public class CoshhAssessment
    {
        [Key]
        public int Id { get; set; }
        public int SubstanceId { get; set; }
        [ForeignKey("SubstanceId")]
        public CoshhSubstance? Substance { get; set; }

        public string TaskDescription { get; set; } = string.Empty; // e.g., "Cleaning stage floor"
        public int? RoomId { get; set; }
        [ForeignKey("RoomId")]
        public Room? Room { get; set; }

        // HSE Control Measures
        public string ControlMeasures { get; set; } = string.Empty;
        public string PPE_Required { get; set; } = "Standard Workwear"; // Gloves, Mask, Goggles
        public string DisposalInstructions { get; set; } = "General Waste";

        public DateTime AssessmentDate { get; set; } = DateTime.Now;
        public DateTime ReviewDueDate { get; set; } = DateTime.Now.AddYears(1);
        public bool IsApproved { get; set; }
    }

    public class FireRiskAssessmentDetails
    {
        [Key]
        public int Id { get; set; }
        public int RiskAssessmentId { get; set; }
        [ForeignKey("RiskAssessmentId")]
        public RiskAssessment? BaseAssessment { get; set; }

        // The 5 Steps Checklist
        public string Step1_IgnitionSources { get; set; } = string.Empty;
        public string Step1_FuelSources { get; set; } = string.Empty;
        public string Step2_PeopleAtRisk { get; set; } = string.Empty;
        public string Step3_EvaluationNotes { get; set; } = string.Empty;
        public string Step4_RecordPlanTrain { get; set; } = string.Empty;

        // Theatre Specifics
        public int MaxOccupancy { get; set; }
        public bool FireCurtainTested { get; set; }
        public string ExitRoutesStatus { get; set; } = "Clear";
    }

    #endregion

}