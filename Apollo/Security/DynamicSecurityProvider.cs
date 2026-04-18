using Microsoft.AspNetCore.Authorization;
using Microsoft.Extensions.Options;
using System.Threading.Tasks;

namespace Apollo.Security
{
    public class DynamicPolicyProvider : DefaultAuthorizationPolicyProvider
    {
        public DynamicPolicyProvider(IOptions<AuthorizationOptions> options) : base(options)
        {
        }

        public override async Task<AuthorizationPolicy?> GetPolicyAsync(string policyName)
        {
            // First, check if it's a standard built-in policy (like a default fallback)
            var policy = await base.GetPolicyAsync(policyName);

            if (policy == null)
            {
                // It's a custom dynamic policy! Let's build the rules on the fly:
                policy = new AuthorizationPolicyBuilder()
                    .RequireAssertion(context =>
                    {
                        // 1. If they have the Deny penalty, instantly block them (Deny always wins)
                        if (context.User.HasClaim(c => c.Type == "DenyPermission" && c.Value == policyName))
                            return false;

                        // 2. GOD MODE CHECK: If they have Admin.FullAccess, instantly let them in!
                        if (context.User.HasClaim(c => c.Type == "Permission" && c.Value == "Admin.FullAccess"))
                            return true;

                        // 3. Otherwise, check if they have the specific permission requested
                        return context.User.HasClaim(c => c.Type == "Permission" && c.Value == policyName);
                    })
                    .Build();
            }

            return policy;
        }
    }
}