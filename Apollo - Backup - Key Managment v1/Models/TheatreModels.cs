using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Apollo.Models
{
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
        [StringLength(100)]
        public string Name { get; set; } = string.Empty;

        [StringLength(100)]
        public string? ContactInfo { get; set; }

        public ICollection<HardwareLock> Locks { get; set; } = new List<HardwareLock>();
    }

    public class HardwareLock
    {
        [Key]
        public int Id { get; set; }

        public bool IsActive { get; set; } = true;

        [Required]
        [StringLength(4)]
        [RegularExpression(@"^[A-Za-z0-9+*&]{1,2}$", ErrorMessage = "Lock code must be 1-4 characters, including alphanumeric, +, *, or &.")]
        public string LockCode { get; set; } = string.Empty;

        [StringLength(10)]
        public string? KeyCode { get; set; }

        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty;

        public int? SupplierId { get; set; } // Optional, in case a lock doesn't have a specific supplier

        [ForeignKey("SupplierId")]
        public Supplier? Supplier { get; set; }

        public string? Manufacturer { get; set; }

        public string Status { get; set; } = "Active";

        public int FormFactorId { get; set; }

        [ForeignKey("FormFactorId")]
        public FormFactor? FormFactor { get; set; }

        public ICollection<Signatory> Signatories { get; set; } = new List<Signatory>();
        public ICollection<KeyRecord> Keys { get; set; } = new List<KeyRecord>();
    }

    public class AuditCampaign
    {
        public int Id { get; set; }
        public string Name { get; set; } = string.Empty; // e.g., "March 2026 Audit"
        public DateTime CreatedAt { get; set; } = DateTime.Now;
}

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

        [StringLength(100)]
        public string? IssuedToName { get; set; }
        public bool IsLostLockout { get; set; } = false;

        public int LockId { get; set; }
        [ForeignKey("LockId")]

        public int? StorageLocationId { get; set; }
        [ForeignKey("StorageLocationId")]
        public StorageLocation? StorageLocation { get; set; }
        public HardwareLock? Lock { get; set; }

        public int? LastAuditCampaignId { get; set; }
        public AuditCampaign? LastAuditCampaign { get; set; }

        public ICollection<KeyBunchAssignment> BunchAssignments { get; set; } = new List<KeyBunchAssignment>();
    }

    public class Bunch
    {
        [Key]
        public int Id { get; set; }

        // This is the line the compiler is looking for!
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
    public class Supplier
    {
        [Key]
        public int Id { get; set; }

        public bool IsActive { get; set; } = true;

        [Required]
        [StringLength(150)]
        public string Name { get; set; } = string.Empty;

        [StringLength(250)]
        public string? Address { get; set; }

        [EmailAddress]
        [StringLength(100)]
        public string? Email { get; set; }

        [Phone]
        [StringLength(50)]
        public string? Phone { get; set; }

        public ICollection<HardwareLock> Locks { get; set; } = new List<HardwareLock>();
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

    public class CheckoutTransaction
    {
        [Key]
        public int Id { get; set; }

        // Make BunchId nullable, since a transaction might just be for a loose key
        public int? BunchId { get; set; }
        [ForeignKey("BunchId")]
        public Bunch? Bunch { get; set; }

        // ADD THIS: Support for individual keys
        public int? KeyRecordId { get; set; }
        [ForeignKey("KeyRecordId")]
        public KeyRecord? KeyRecord { get; set; }

        [Required]
        [StringLength(100)]
        public string IssuedToName { get; set; } = string.Empty;

        [Required]
        public DateTime IssueDate { get; set; }

        public DateTime? ReturnDate { get; set; }

        public string? AuthorizedByUserName { get; set; }
    }

    public class AuditLog
    {
        [Key]
        public int Id { get; set; }

        public string? UserId { get; set; } // Will hold the user who made the change once we add Identity

        [Required]
        [StringLength(50)]
        public string ActionType { get; set; } = string.Empty; // e.g., "Create", "Update", "Delete"

        [Required]
        [StringLength(100)]
        public string TableName { get; set; } = string.Empty;

        public string PrimaryKey { get; set; } = string.Empty; // The ID of the row that was changed

        public string? OldValues { get; set; } // JSON string of what it looked like before

        public string? NewValues { get; set; } // JSON string of what it looks like now

        public DateTime Timestamp { get; set; } = DateTime.Now;


    }

    public class StorageLocation
    {
        [Key]
        public int Id { get; set; }
        public bool IsActive { get; set; } = true;

        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty; // e.g., "Foyer Cupboard", "Tech Safe"
    }

    public class Department
    {
        [Key]
        public int Id { get; set; }
        public bool IsActive { get; set; } = true;

        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty; // e.g., "Technical Manager", "Front of House"
    }

    public class SystemPermission
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(50)]
        public string Module { get; set; } = string.Empty; // e.g., "Keys", "Admin", "Radios"

        [Required]
        [StringLength(100)]
        public string Name { get; set; } = string.Empty; // e.g., "Issue and Return Items"

        [Required]
        [StringLength(100)]
        public string ClaimValue { get; set; } = string.Empty; // e.g., "Keys.IssueReturn"
    }
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

        public string? CustomLinksJson { get; set; } = "[]";

        // Module Toggles
        public bool IsKeyManagementEnabled { get; set; } = true;
        public bool IsReportsEnabled { get; set; } = true;
        public bool IsAdminEnabled { get; set; } = true;
        public bool IsRoomBookingsEnabled { get; set; } = false;
        public bool IsBoxOfficeEnabled { get; set; } = false;
    }

    public class TopBarLink
    {
        public string Title { get; set; } = string.Empty;
        public string Url { get; set; } = string.Empty;
        public string IconClass { get; set; } = "bi-link-45deg";
    }


}