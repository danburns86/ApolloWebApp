using System.Collections.Generic;

namespace Apollo.Models
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

        // Helper to load them into the UI Matrix
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
                ManageSystemSettings
            };
        }
    }
}