using Apollo.Components;
using Apollo.Components.Account;
using Apollo.Data;
using Apollo.Security;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// 1. Add Razor Components
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

builder.Services.AddCascadingAuthenticationState();
builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<IdentityRedirectManager>();
builder.Services.AddScoped<AuthenticationStateProvider, IdentityRevalidatingAuthenticationStateProvider>();

builder.Services.AddAuthentication(options =>
{
    options.DefaultScheme = IdentityConstants.ApplicationScheme;
    options.DefaultSignInScheme = IdentityConstants.ExternalScheme;
})
    .AddIdentityCookies();

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");

// 2. DATABASE CONFIGURATION (Factory + Scoped)
// This solves the NavMenu concurrency crash by allowing the Factory to create private contexts.
builder.Services.AddDbContextFactory<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString), ServiceLifetime.Scoped);

// This allows Identity and other standard pages to use the database normally
builder.Services.AddScoped(p =>
    p.GetRequiredService<IDbContextFactory<ApplicationDbContext>>().CreateDbContext());

builder.Services.AddDatabaseDeveloperPageExceptionFilter();

// 3. IDENTITY CONFIGURATION
builder.Services.AddIdentityCore<ApplicationUser>(options =>
{
    options.SignIn.RequireConfirmedAccount = true;
})
    .AddRoles<IdentityRole>()
    .AddEntityFrameworkStores<ApplicationDbContext>()
    .AddSignInManager()
    .AddDefaultTokenProviders();

builder.Services.AddSingleton<IEmailSender<ApplicationUser>, IdentityNoOpEmailSender>();
builder.Services.AddSingleton<IAuthorizationPolicyProvider, DynamicPolicyProvider>();
builder.Services.AddAuthorizationCore();

// 4. BUILD THE APP (Exactly once!)
var app = builder.Build();

// 5. CONFIGURE PIPELINE
if (app.Environment.IsDevelopment())
{
    app.UseMigrationsEndPoint();
}
else
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    app.UseHsts();
}

// Intercept 404s and push them to your custom page
app.UseStatusCodePagesWithReExecute("/not-found");

app.UseHttpsRedirection();
app.MapStaticAssets(); // (Note: MapStaticAssets is the .NET 8/9 equivalent of UseStaticFiles)

app.UseRouting(); // 1. Match the URL to an endpoint

app.UseAuthentication(); // 2. Figure out WHO the user is (Missing previously!)
app.UseAuthorization();  // 3. Figure out WHAT they can do (Missing previously!)
app.UseAntiforgery();    // 4. Protect against cross-site request forgery

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.MapAdditionalIdentityEndpoints();

// 6. SEEDING LOGIC
using (var scope = app.Services.CreateScope())
{
    var roleManager = scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole>>();
    var userManager = scope.ServiceProvider.GetRequiredService<UserManager<ApplicationUser>>();

    string[] roleNames = { "Administrator", "Auditor", "DepartmentHead" };
    foreach (var roleName in roleNames)
    {
        if (!await roleManager.RoleExistsAsync(roleName))
        {
            await roleManager.CreateAsync(new IdentityRole(roleName));
        }
    }

    string adminEmail = "admin@apollo.local";
    string adminPassword = "Password123!";

    var adminUser = await userManager.FindByEmailAsync(adminEmail);
    if (adminUser == null)
    {
        var newAdmin = new ApplicationUser
        {
            UserName = adminEmail,
            Email = adminEmail,
            EmailConfirmed = true
        };

        var createPowerUser = await userManager.CreateAsync(newAdmin, adminPassword);
        if (createPowerUser.Succeeded)
        {
            await userManager.AddToRoleAsync(newAdmin, "Administrator");
        }
    }
}

app.Run();