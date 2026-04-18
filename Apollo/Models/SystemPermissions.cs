using System.Collections.Generic;

namespace Apollo.Models // Change namespace to Security to keep it organized
{
    public static class SystemPermissions
    {
        // Core Inventory
        public const string ViewInventory = "Inventory.View";
        public const string CreateKeys = "Keys.Create";
        public const string CreateBunches = "Bunches.Create";

        // Operations
        public const string IssueReturn = "Transactions.IssueReturn";
        public const string PerformAudit = "Audit.Perform";

        // Admin
        public const string ManageUsers = "Admin.ManageUsers";
        public const string ManageSystemSettings = "Admin.ManageSettings";

        // Facilities & Locations
        public const string ViewFacilities = "Facilities.View";
        public const string ManageFacilities = "Facilities.Manage";

        // Maintenance
        public const string ViewMaintenance = "Maintenance.View";
        public const string ManageMaintenance = "Maintenance.Manage";
        public const string ContractorView = "Maintenance.ContractorView";

        // Asset Tracking
        public const string ViewAssets = "Assets.View";
        public const string ManageAssets = "Assets.Manage";

        // IMPORTANT: Add the new ones to this list so they appear in your Role Matrix!
        public static List<string> GetAllPermissions()
        {
            return new List<string>
            {
                ViewInventory,
                CreateKeys,
                CreateBunches,
                IssueReturn,
                PerformAudit,
                ManageUsers,
                ManageSystemSettings,
                ViewFacilities,
                ManageFacilities,
                ViewMaintenance,
                ManageMaintenance,
                ContractorView,
                ViewAssets,    // ADDED
                ManageAssets   // ADDED
            };
        }
    }
}