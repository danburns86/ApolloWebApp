IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE TABLE [AspNetRoles] (
        [Id] nvarchar(450) NOT NULL,
        [Name] nvarchar(256) NULL,
        [NormalizedName] nvarchar(256) NULL,
        [ConcurrencyStamp] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE TABLE [AspNetUsers] (
        [Id] nvarchar(450) NOT NULL,
        [UserName] nvarchar(256) NULL,
        [NormalizedUserName] nvarchar(256) NULL,
        [Email] nvarchar(256) NULL,
        [NormalizedEmail] nvarchar(256) NULL,
        [EmailConfirmed] bit NOT NULL,
        [PasswordHash] nvarchar(max) NULL,
        [SecurityStamp] nvarchar(max) NULL,
        [ConcurrencyStamp] nvarchar(max) NULL,
        [PhoneNumber] nvarchar(256) NULL,
        [PhoneNumberConfirmed] bit NOT NULL,
        [TwoFactorEnabled] bit NOT NULL,
        [LockoutEnd] datetimeoffset NULL,
        [LockoutEnabled] bit NOT NULL,
        [AccessFailedCount] int NOT NULL,
        CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE TABLE [AspNetRoleClaims] (
        [Id] int NOT NULL IDENTITY,
        [RoleId] nvarchar(450) NOT NULL,
        [ClaimType] nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE TABLE [AspNetUserClaims] (
        [Id] int NOT NULL IDENTITY,
        [UserId] nvarchar(450) NOT NULL,
        [ClaimType] nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE TABLE [AspNetUserLogins] (
        [LoginProvider] nvarchar(128) NOT NULL,
        [ProviderKey] nvarchar(128) NOT NULL,
        [ProviderDisplayName] nvarchar(max) NULL,
        [UserId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
        CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE TABLE [AspNetUserPasskeys] (
        [CredentialId] varbinary(1024) NOT NULL,
        [UserId] nvarchar(450) NOT NULL,
        [Data] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_AspNetUserPasskeys] PRIMARY KEY ([CredentialId]),
        CONSTRAINT [FK_AspNetUserPasskeys_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE TABLE [AspNetUserRoles] (
        [UserId] nvarchar(450) NOT NULL,
        [RoleId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
        CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE TABLE [AspNetUserTokens] (
        [UserId] nvarchar(450) NOT NULL,
        [LoginProvider] nvarchar(128) NOT NULL,
        [Name] nvarchar(128) NOT NULL,
        [Value] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
        CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE INDEX [IX_AspNetUserPasskeys_UserId] ON [AspNetUserPasskeys] ([UserId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'00000000000000_CreateIdentitySchema'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'00000000000000_CreateIdentitySchema', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    CREATE TABLE [Bunches] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(100) NOT NULL,
        [ResponsibleUserId] nvarchar(max) NULL,
        [IssuedToName] nvarchar(100) NULL,
        [IssueDate] datetime2 NULL,
        [ReturnDate] datetime2 NULL,
        CONSTRAINT [PK_Bunches] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    CREATE TABLE [FormFactors] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_FormFactors] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    CREATE TABLE [Signatories] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(100) NOT NULL,
        [ContactInfo] nvarchar(100) NULL,
        CONSTRAINT [PK_Signatories] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    CREATE TABLE [Locks] (
        [Id] int NOT NULL IDENTITY,
        [LockCode] nvarchar(2) NOT NULL,
        [KeyCode] nvarchar(10) NULL,
        [Name] nvarchar(100) NOT NULL,
        [Supplier] nvarchar(100) NULL,
        [Manufacturer] nvarchar(100) NULL,
        [Status] nvarchar(max) NOT NULL,
        [FormFactorId] int NOT NULL,
        CONSTRAINT [PK_Locks] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Locks_FormFactors_FormFactorId] FOREIGN KEY ([FormFactorId]) REFERENCES [FormFactors] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    CREATE TABLE [HardwareLockSignatory] (
        [LocksId] int NOT NULL,
        [SignatoriesId] int NOT NULL,
        CONSTRAINT [PK_HardwareLockSignatory] PRIMARY KEY ([LocksId], [SignatoriesId]),
        CONSTRAINT [FK_HardwareLockSignatory_Locks_LocksId] FOREIGN KEY ([LocksId]) REFERENCES [Locks] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_HardwareLockSignatory_Signatories_SignatoriesId] FOREIGN KEY ([SignatoriesId]) REFERENCES [Signatories] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    CREATE TABLE [Keys] (
        [Id] int NOT NULL IDENTITY,
        [SequenceNumber] int NOT NULL,
        [Status] nvarchar(20) NOT NULL,
        [LastSeenDate] datetime2 NULL,
        [IsLostLockout] bit NOT NULL,
        [LockId] int NOT NULL,
        CONSTRAINT [PK_Keys] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Keys_Locks_LockId] FOREIGN KEY ([LockId]) REFERENCES [Locks] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    CREATE TABLE [KeyBunchAssignments] (
        [Id] int NOT NULL IDENTITY,
        [KeyRecordId] int NOT NULL,
        [BunchId] int NOT NULL,
        [AssignedDate] datetime2 NOT NULL,
        [RemovedDate] datetime2 NULL,
        CONSTRAINT [PK_KeyBunchAssignments] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_KeyBunchAssignments_Bunches_BunchId] FOREIGN KEY ([BunchId]) REFERENCES [Bunches] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_KeyBunchAssignments_Keys_KeyRecordId] FOREIGN KEY ([KeyRecordId]) REFERENCES [Keys] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    CREATE INDEX [IX_HardwareLockSignatory_SignatoriesId] ON [HardwareLockSignatory] ([SignatoriesId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    CREATE INDEX [IX_KeyBunchAssignments_BunchId] ON [KeyBunchAssignments] ([BunchId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    CREATE INDEX [IX_KeyBunchAssignments_KeyRecordId] ON [KeyBunchAssignments] ([KeyRecordId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    CREATE INDEX [IX_Keys_LockId] ON [Keys] ([LockId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    CREATE INDEX [IX_Locks_FormFactorId] ON [Locks] ([FormFactorId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414164121_InitialKeyManagerSchema'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260414164121_InitialKeyManagerSchema', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414204042_AddSupplierTable'
)
BEGIN
    DECLARE @var nvarchar(max);
    SELECT @var = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Locks]') AND [c].[name] = N'Supplier');
    IF @var IS NOT NULL EXEC(N'ALTER TABLE [Locks] DROP CONSTRAINT ' + @var + ';');
    ALTER TABLE [Locks] DROP COLUMN [Supplier];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414204042_AddSupplierTable'
)
BEGIN
    DECLARE @var1 nvarchar(max);
    SELECT @var1 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Locks]') AND [c].[name] = N'Manufacturer');
    IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Locks] DROP CONSTRAINT ' + @var1 + ';');
    ALTER TABLE [Locks] ALTER COLUMN [Manufacturer] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414204042_AddSupplierTable'
)
BEGIN
    ALTER TABLE [Locks] ADD [SupplierId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414204042_AddSupplierTable'
)
BEGIN
    CREATE TABLE [Suppliers] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(150) NOT NULL,
        [Address] nvarchar(250) NULL,
        [Email] nvarchar(100) NULL,
        [Phone] nvarchar(50) NULL,
        CONSTRAINT [PK_Suppliers] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414204042_AddSupplierTable'
)
BEGIN
    CREATE INDEX [IX_Locks_SupplierId] ON [Locks] ([SupplierId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414204042_AddSupplierTable'
)
BEGIN
    ALTER TABLE [Locks] ADD CONSTRAINT [FK_Locks_Suppliers_SupplierId] FOREIGN KEY ([SupplierId]) REFERENCES [Suppliers] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414204042_AddSupplierTable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260414204042_AddSupplierTable', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414205821_AddIsActiveFlags'
)
BEGIN
    ALTER TABLE [Suppliers] ADD [IsActive] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414205821_AddIsActiveFlags'
)
BEGIN
    ALTER TABLE [Signatories] ADD [IsActive] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414205821_AddIsActiveFlags'
)
BEGIN
    ALTER TABLE [Locks] ADD [IsActive] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414205821_AddIsActiveFlags'
)
BEGIN
    ALTER TABLE [FormFactors] ADD [IsActive] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414205821_AddIsActiveFlags'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260414205821_AddIsActiveFlags', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414213941_AddBunchIsActiveFlag'
)
BEGIN
    ALTER TABLE [Bunches] ADD [IsActive] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414213941_AddBunchIsActiveFlag'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260414213941_AddBunchIsActiveFlag', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414214447_AddBunchIsLostFlag'
)
BEGIN
    ALTER TABLE [Bunches] ADD [IsLost] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414214447_AddBunchIsLostFlag'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260414214447_AddBunchIsLostFlag', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414215357_AddCheckoutTransactions'
)
BEGIN
    CREATE TABLE [CheckoutTransactions] (
        [Id] int NOT NULL IDENTITY,
        [BunchId] int NOT NULL,
        [IssuedToName] nvarchar(100) NOT NULL,
        [IssueDate] datetime2 NOT NULL,
        [ReturnDate] datetime2 NULL,
        CONSTRAINT [PK_CheckoutTransactions] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_CheckoutTransactions_Bunches_BunchId] FOREIGN KEY ([BunchId]) REFERENCES [Bunches] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414215357_AddCheckoutTransactions'
)
BEGIN
    CREATE INDEX [IX_CheckoutTransactions_BunchId] ON [CheckoutTransactions] ([BunchId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414215357_AddCheckoutTransactions'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260414215357_AddCheckoutTransactions', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414220003_AddGlobalAuditLog'
)
BEGIN
    DROP TABLE [AspNetRoleClaims];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414220003_AddGlobalAuditLog'
)
BEGIN
    DROP TABLE [AspNetUserClaims];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414220003_AddGlobalAuditLog'
)
BEGIN
    DROP TABLE [AspNetUserLogins];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414220003_AddGlobalAuditLog'
)
BEGIN
    DROP TABLE [AspNetUserPasskeys];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414220003_AddGlobalAuditLog'
)
BEGIN
    DROP TABLE [AspNetUserRoles];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414220003_AddGlobalAuditLog'
)
BEGIN
    DROP TABLE [AspNetUserTokens];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414220003_AddGlobalAuditLog'
)
BEGIN
    DROP TABLE [AspNetRoles];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414220003_AddGlobalAuditLog'
)
BEGIN
    DROP TABLE [AspNetUsers];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414220003_AddGlobalAuditLog'
)
BEGIN
    CREATE TABLE [AuditLogs] (
        [Id] int NOT NULL IDENTITY,
        [UserId] nvarchar(max) NULL,
        [ActionType] nvarchar(50) NOT NULL,
        [TableName] nvarchar(100) NOT NULL,
        [PrimaryKey] nvarchar(max) NOT NULL,
        [OldValues] nvarchar(max) NULL,
        [NewValues] nvarchar(max) NULL,
        [Timestamp] datetime2 NOT NULL,
        CONSTRAINT [PK_AuditLogs] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260414220003_AddGlobalAuditLog'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260414220003_AddGlobalAuditLog', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE TABLE [AspNetRoles] (
        [Id] nvarchar(450) NOT NULL,
        [Name] nvarchar(256) NULL,
        [NormalizedName] nvarchar(256) NULL,
        [ConcurrencyStamp] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE TABLE [AspNetUsers] (
        [Id] nvarchar(450) NOT NULL,
        [UserName] nvarchar(256) NULL,
        [NormalizedUserName] nvarchar(256) NULL,
        [Email] nvarchar(256) NULL,
        [NormalizedEmail] nvarchar(256) NULL,
        [EmailConfirmed] bit NOT NULL,
        [PasswordHash] nvarchar(max) NULL,
        [SecurityStamp] nvarchar(max) NULL,
        [ConcurrencyStamp] nvarchar(max) NULL,
        [PhoneNumber] nvarchar(256) NULL,
        [PhoneNumberConfirmed] bit NOT NULL,
        [TwoFactorEnabled] bit NOT NULL,
        [LockoutEnd] datetimeoffset NULL,
        [LockoutEnabled] bit NOT NULL,
        [AccessFailedCount] int NOT NULL,
        CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE TABLE [AspNetRoleClaims] (
        [Id] int NOT NULL IDENTITY,
        [RoleId] nvarchar(450) NOT NULL,
        [ClaimType] nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE TABLE [AspNetUserClaims] (
        [Id] int NOT NULL IDENTITY,
        [UserId] nvarchar(450) NOT NULL,
        [ClaimType] nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE TABLE [AspNetUserLogins] (
        [LoginProvider] nvarchar(128) NOT NULL,
        [ProviderKey] nvarchar(128) NOT NULL,
        [ProviderDisplayName] nvarchar(max) NULL,
        [UserId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
        CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE TABLE [AspNetUserPasskeys] (
        [CredentialId] varbinary(1024) NOT NULL,
        [UserId] nvarchar(450) NOT NULL,
        [Data] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_AspNetUserPasskeys] PRIMARY KEY ([CredentialId]),
        CONSTRAINT [FK_AspNetUserPasskeys_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE TABLE [AspNetUserRoles] (
        [UserId] nvarchar(450) NOT NULL,
        [RoleId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
        CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE TABLE [AspNetUserTokens] (
        [UserId] nvarchar(450) NOT NULL,
        [LoginProvider] nvarchar(128) NOT NULL,
        [Name] nvarchar(128) NOT NULL,
        [Value] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
        CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE INDEX [IX_AspNetUserPasskeys_UserId] ON [AspNetUserPasskeys] ([UserId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415072141_FixIdentityInheritance'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260415072141_FixIdentityInheritance', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    DECLARE @var2 nvarchar(max);
    SELECT @var2 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Bunches]') AND [c].[name] = N'ResponsibleUserId');
    IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Bunches] DROP CONSTRAINT ' + @var2 + ';');
    ALTER TABLE [Bunches] DROP COLUMN [ResponsibleUserId];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    ALTER TABLE [Keys] ADD [StorageLocationId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    DECLARE @var3 nvarchar(max);
    SELECT @var3 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Bunches]') AND [c].[name] = N'IssuedToName');
    IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [Bunches] DROP CONSTRAINT ' + @var3 + ';');
    ALTER TABLE [Bunches] ALTER COLUMN [IssuedToName] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    ALTER TABLE [Bunches] ADD [DepartmentId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    ALTER TABLE [Bunches] ADD [StorageLocationId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    CREATE TABLE [Departments] (
        [Id] int NOT NULL IDENTITY,
        [IsActive] bit NOT NULL,
        [Name] nvarchar(100) NOT NULL,
        CONSTRAINT [PK_Departments] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    CREATE TABLE [StorageLocations] (
        [Id] int NOT NULL IDENTITY,
        [IsActive] bit NOT NULL,
        [Name] nvarchar(100) NOT NULL,
        CONSTRAINT [PK_StorageLocations] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    CREATE INDEX [IX_Keys_StorageLocationId] ON [Keys] ([StorageLocationId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    CREATE INDEX [IX_Bunches_DepartmentId] ON [Bunches] ([DepartmentId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    CREATE INDEX [IX_Bunches_StorageLocationId] ON [Bunches] ([StorageLocationId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    ALTER TABLE [Bunches] ADD CONSTRAINT [FK_Bunches_Departments_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Departments] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    ALTER TABLE [Bunches] ADD CONSTRAINT [FK_Bunches_StorageLocations_StorageLocationId] FOREIGN KEY ([StorageLocationId]) REFERENCES [StorageLocations] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    ALTER TABLE [Keys] ADD CONSTRAINT [FK_Keys_StorageLocations_StorageLocationId] FOREIGN KEY ([StorageLocationId]) REFERENCES [StorageLocations] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415074439_AddLocationsAndDepartments'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260415074439_AddLocationsAndDepartments', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415075146_AddFormalAuditDate'
)
BEGIN
    ALTER TABLE [Keys] ADD [LastFormalAuditDate] datetime2 NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415075146_AddFormalAuditDate'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260415075146_AddFormalAuditDate', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415075505_AddIndividualKeyCheckouts'
)
BEGIN
    ALTER TABLE [CheckoutTransactions] DROP CONSTRAINT [FK_CheckoutTransactions_Bunches_BunchId];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415075505_AddIndividualKeyCheckouts'
)
BEGIN
    ALTER TABLE [Keys] ADD [IssuedToName] nvarchar(100) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415075505_AddIndividualKeyCheckouts'
)
BEGIN
    DECLARE @var4 nvarchar(max);
    SELECT @var4 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CheckoutTransactions]') AND [c].[name] = N'BunchId');
    IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [CheckoutTransactions] DROP CONSTRAINT ' + @var4 + ';');
    ALTER TABLE [CheckoutTransactions] ALTER COLUMN [BunchId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415075505_AddIndividualKeyCheckouts'
)
BEGIN
    ALTER TABLE [CheckoutTransactions] ADD [KeyRecordId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415075505_AddIndividualKeyCheckouts'
)
BEGIN
    CREATE INDEX [IX_CheckoutTransactions_KeyRecordId] ON [CheckoutTransactions] ([KeyRecordId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415075505_AddIndividualKeyCheckouts'
)
BEGIN
    ALTER TABLE [CheckoutTransactions] ADD CONSTRAINT [FK_CheckoutTransactions_Bunches_BunchId] FOREIGN KEY ([BunchId]) REFERENCES [Bunches] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415075505_AddIndividualKeyCheckouts'
)
BEGIN
    ALTER TABLE [CheckoutTransactions] ADD CONSTRAINT [FK_CheckoutTransactions_Keys_KeyRecordId] FOREIGN KEY ([KeyRecordId]) REFERENCES [Keys] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415075505_AddIndividualKeyCheckouts'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260415075505_AddIndividualKeyCheckouts', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415091556_AddSystemPermissions'
)
BEGIN
    CREATE TABLE [SystemPermissions] (
        [Id] int NOT NULL IDENTITY,
        [Module] nvarchar(50) NOT NULL,
        [Name] nvarchar(100) NOT NULL,
        [ClaimValue] nvarchar(100) NOT NULL,
        CONSTRAINT [PK_SystemPermissions] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415091556_AddSystemPermissions'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260415091556_AddSystemPermissions', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415185349_AddPortalConfig'
)
BEGIN
    ALTER TABLE [AspNetUsers] ADD [FirstName] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415185349_AddPortalConfig'
)
BEGIN
    ALTER TABLE [AspNetUsers] ADD [LastName] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415185349_AddPortalConfig'
)
BEGIN
    CREATE TABLE [PortalConfigurations] (
        [Id] int NOT NULL IDENTITY,
        [WelcomeHeading] nvarchar(100) NOT NULL,
        [WelcomeMessage] nvarchar(250) NOT NULL,
        [NavbarLogoUrl] nvarchar(max) NULL,
        [FaviconUrl] nvarchar(max) NULL,
        [IsKeyManagementEnabled] bit NOT NULL,
        [IsReportsEnabled] bit NOT NULL,
        [IsAdminEnabled] bit NOT NULL,
        [IsRoomBookingsEnabled] bit NOT NULL,
        [IsBoxOfficeEnabled] bit NOT NULL,
        CONSTRAINT [PK_PortalConfigurations] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415185349_AddPortalConfig'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260415185349_AddPortalConfig', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415195339_AddAuditCampaignsTable'
)
BEGIN
    ALTER TABLE [Keys] ADD [LastAuditCampaignId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415195339_AddAuditCampaignsTable'
)
BEGIN
    CREATE TABLE [AuditCampaigns] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [CreatedAt] datetime2 NOT NULL,
        CONSTRAINT [PK_AuditCampaigns] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415195339_AddAuditCampaignsTable'
)
BEGIN
    CREATE INDEX [IX_Keys_LastAuditCampaignId] ON [Keys] ([LastAuditCampaignId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415195339_AddAuditCampaignsTable'
)
BEGIN
    ALTER TABLE [Keys] ADD CONSTRAINT [FK_Keys_AuditCampaigns_LastAuditCampaignId] FOREIGN KEY ([LastAuditCampaignId]) REFERENCES [AuditCampaigns] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415195339_AddAuditCampaignsTable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260415195339_AddAuditCampaignsTable', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415200326_AddAuthorizedBy'
)
BEGIN
    ALTER TABLE [CheckoutTransactions] ADD [AuthorizedByUserName] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260415200326_AddAuthorizedBy'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260415200326_AddAuthorizedBy', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416160624_TopBarLinks'
)
BEGIN
    DROP TABLE [AspNetUserPasskeys];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416160624_TopBarLinks'
)
BEGIN
    DECLARE @var5 nvarchar(max);
    SELECT @var5 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUserTokens]') AND [c].[name] = N'Name');
    IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUserTokens] DROP CONSTRAINT ' + @var5 + ';');
    ALTER TABLE [AspNetUserTokens] ALTER COLUMN [Name] nvarchar(450) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416160624_TopBarLinks'
)
BEGIN
    DECLARE @var6 nvarchar(max);
    SELECT @var6 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUserTokens]') AND [c].[name] = N'LoginProvider');
    IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUserTokens] DROP CONSTRAINT ' + @var6 + ';');
    ALTER TABLE [AspNetUserTokens] ALTER COLUMN [LoginProvider] nvarchar(450) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416160624_TopBarLinks'
)
BEGIN
    DECLARE @var7 nvarchar(max);
    SELECT @var7 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUsers]') AND [c].[name] = N'PhoneNumber');
    IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUsers] DROP CONSTRAINT ' + @var7 + ';');
    ALTER TABLE [AspNetUsers] ALTER COLUMN [PhoneNumber] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416160624_TopBarLinks'
)
BEGIN
    DECLARE @var8 nvarchar(max);
    SELECT @var8 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUserLogins]') AND [c].[name] = N'ProviderKey');
    IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUserLogins] DROP CONSTRAINT ' + @var8 + ';');
    ALTER TABLE [AspNetUserLogins] ALTER COLUMN [ProviderKey] nvarchar(450) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416160624_TopBarLinks'
)
BEGIN
    DECLARE @var9 nvarchar(max);
    SELECT @var9 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AspNetUserLogins]') AND [c].[name] = N'LoginProvider');
    IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [AspNetUserLogins] DROP CONSTRAINT ' + @var9 + ';');
    ALTER TABLE [AspNetUserLogins] ALTER COLUMN [LoginProvider] nvarchar(450) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416160624_TopBarLinks'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260416160624_TopBarLinks', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416160925_AddTopBarLinks'
)
BEGIN
    ALTER TABLE [PortalConfigurations] ADD [CustomLinksJson] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416160925_AddTopBarLinks'
)
BEGIN
    ALTER TABLE [PortalConfigurations] ADD [TheatreName] nvarchar(100) NOT NULL DEFAULT N'';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416160925_AddTopBarLinks'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260416160925_AddTopBarLinks', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416162145_UpdateLockCodeRegex'
)
BEGIN
    DECLARE @var10 nvarchar(max);
    SELECT @var10 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Locks]') AND [c].[name] = N'LockCode');
    IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [Locks] DROP CONSTRAINT ' + @var10 + ';');
    ALTER TABLE [Locks] ALTER COLUMN [LockCode] nvarchar(4) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416162145_UpdateLockCodeRegex'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260416162145_UpdateLockCodeRegex', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416193735_AddHierarchicalLocations'
)
BEGIN
    ALTER TABLE [Locks] ADD [RoomId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416193735_AddHierarchicalLocations'
)
BEGIN
    CREATE TABLE [Areas] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_Areas] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416193735_AddHierarchicalLocations'
)
BEGIN
    CREATE TABLE [Rooms] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [AreaId] int NOT NULL,
        [NearestExit] nvarchar(max) NOT NULL,
        [NearestCallPoint] nvarchar(max) NOT NULL,
        [FireActionNotes] nvarchar(max) NOT NULL,
        [MRBSRoomId] int NULL,
        [IsPublic] bit NOT NULL,
        [IsActive] bit NOT NULL,
        CONSTRAINT [PK_Rooms] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Rooms_Areas_AreaId] FOREIGN KEY ([AreaId]) REFERENCES [Areas] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416193735_AddHierarchicalLocations'
)
BEGIN
    CREATE INDEX [IX_Locks_RoomId] ON [Locks] ([RoomId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416193735_AddHierarchicalLocations'
)
BEGIN
    CREATE INDEX [IX_Rooms_AreaId] ON [Rooms] ([AreaId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416193735_AddHierarchicalLocations'
)
BEGIN
    ALTER TABLE [Locks] ADD CONSTRAINT [FK_Locks_Rooms_RoomId] FOREIGN KEY ([RoomId]) REFERENCES [Rooms] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260416193735_AddHierarchicalLocations'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260416193735_AddHierarchicalLocations', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417080557_MergePortalConfiguration'
)
BEGIN
    DECLARE @var11 nvarchar(max);
    SELECT @var11 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Rooms]') AND [c].[name] = N'NearestExit');
    IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [Rooms] DROP CONSTRAINT ' + @var11 + ';');
    ALTER TABLE [Rooms] ALTER COLUMN [NearestExit] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417080557_MergePortalConfiguration'
)
BEGIN
    DECLARE @var12 nvarchar(max);
    SELECT @var12 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Rooms]') AND [c].[name] = N'NearestCallPoint');
    IF @var12 IS NOT NULL EXEC(N'ALTER TABLE [Rooms] DROP CONSTRAINT ' + @var12 + ';');
    ALTER TABLE [Rooms] ALTER COLUMN [NearestCallPoint] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417080557_MergePortalConfiguration'
)
BEGIN
    DECLARE @var13 nvarchar(max);
    SELECT @var13 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Rooms]') AND [c].[name] = N'FireActionNotes');
    IF @var13 IS NOT NULL EXEC(N'ALTER TABLE [Rooms] DROP CONSTRAINT ' + @var13 + ';');
    ALTER TABLE [Rooms] ALTER COLUMN [FireActionNotes] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417080557_MergePortalConfiguration'
)
BEGIN
    ALTER TABLE [PortalConfigurations] ADD [StaleCheckoutHours] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417080557_MergePortalConfiguration'
)
BEGIN
    DECLARE @var14 nvarchar(max);
    SELECT @var14 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Areas]') AND [c].[name] = N'Description');
    IF @var14 IS NOT NULL EXEC(N'ALTER TABLE [Areas] DROP CONSTRAINT ' + @var14 + ';');
    ALTER TABLE [Areas] ALTER COLUMN [Description] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417080557_MergePortalConfiguration'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417080557_MergePortalConfiguration', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417082651_AddAlternativeExits'
)
BEGIN
    EXEC sp_rename N'[Rooms].[NearestCallPoint]', N'CallPoints', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417082651_AddAlternativeExits'
)
BEGIN
    ALTER TABLE [Rooms] ADD [AlternativeExit] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417082651_AddAlternativeExits'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417082651_AddAlternativeExits', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417083235_AddMaintenanceHub'
)
BEGIN
    ALTER TABLE [PortalConfigurations] ADD [StageDoorPasscode] nvarchar(max) NOT NULL DEFAULT N'';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417083235_AddMaintenanceHub'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417083235_AddMaintenanceHub', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417084339_AddMaintenanceAndPasscode'
)
BEGIN
    DECLARE @var15 nvarchar(max);
    SELECT @var15 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[PortalConfigurations]') AND [c].[name] = N'StageDoorPasscode');
    IF @var15 IS NOT NULL EXEC(N'ALTER TABLE [PortalConfigurations] DROP CONSTRAINT ' + @var15 + ';');
    ALTER TABLE [PortalConfigurations] ALTER COLUMN [StageDoorPasscode] nvarchar(20) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417084339_AddMaintenanceAndPasscode'
)
BEGIN
    CREATE TABLE [MaintenanceIssues] (
        [Id] int NOT NULL IDENTITY,
        [RoomId] int NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        [Severity] int NOT NULL,
        [Status] int NOT NULL,
        [ReportedByName] nvarchar(max) NULL,
        [ReportedAt] datetime2 NOT NULL,
        [AdminNotes] nvarchar(max) NULL,
        [ResolvedAt] datetime2 NULL,
        CONSTRAINT [PK_MaintenanceIssues] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_MaintenanceIssues_Rooms_RoomId] FOREIGN KEY ([RoomId]) REFERENCES [Rooms] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417084339_AddMaintenanceAndPasscode'
)
BEGIN
    CREATE INDEX [IX_MaintenanceIssues_RoomId] ON [MaintenanceIssues] ([RoomId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417084339_AddMaintenanceAndPasscode'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417084339_AddMaintenanceAndPasscode', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417085845_AddMaintenanceHub2'
)
BEGIN
    ALTER TABLE [MaintenanceIssues] ADD [ImagePath] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417085845_AddMaintenanceHub2'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417085845_AddMaintenanceHub2', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417101522_AddMaintenanceAssignments'
)
BEGIN
    ALTER TABLE [MaintenanceIssues] ADD [AssignedTo] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417101522_AddMaintenanceAssignments'
)
BEGIN
    ALTER TABLE [MaintenanceIssues] ADD [ContractorCompany] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417101522_AddMaintenanceAssignments'
)
BEGIN
    ALTER TABLE [MaintenanceIssues] ADD [QuoteReference] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417101522_AddMaintenanceAssignments'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417101522_AddMaintenanceAssignments', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417103715_AddTicketingAndParts'
)
BEGIN
    CREATE TABLE [MaintenanceNotes] (
        [Id] int NOT NULL IDENTITY,
        [MaintenanceIssueId] int NOT NULL,
        [NoteText] nvarchar(max) NOT NULL,
        [CreatedAt] datetime2 NOT NULL,
        [CreatedBy] nvarchar(max) NULL,
        [StatusChange] int NULL,
        CONSTRAINT [PK_MaintenanceNotes] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_MaintenanceNotes_MaintenanceIssues_MaintenanceIssueId] FOREIGN KEY ([MaintenanceIssueId]) REFERENCES [MaintenanceIssues] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417103715_AddTicketingAndParts'
)
BEGIN
    CREATE TABLE [MaintenanceParts] (
        [Id] int NOT NULL IDENTITY,
        [MaintenanceIssueId] int NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        [Quantity] int NOT NULL,
        [InStock] bit NOT NULL,
        [NeedsOrdering] bit NOT NULL,
        [IsOrdered] bit NOT NULL,
        CONSTRAINT [PK_MaintenanceParts] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_MaintenanceParts_MaintenanceIssues_MaintenanceIssueId] FOREIGN KEY ([MaintenanceIssueId]) REFERENCES [MaintenanceIssues] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417103715_AddTicketingAndParts'
)
BEGIN
    CREATE INDEX [IX_MaintenanceNotes_MaintenanceIssueId] ON [MaintenanceNotes] ([MaintenanceIssueId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417103715_AddTicketingAndParts'
)
BEGIN
    CREATE INDEX [IX_MaintenanceParts_MaintenanceIssueId] ON [MaintenanceParts] ([MaintenanceIssueId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417103715_AddTicketingAndParts'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417103715_AddTicketingAndParts', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417125835_AddAssetTracking'
)
BEGIN
    ALTER TABLE [MaintenanceIssues] ADD [AssetId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417125835_AddAssetTracking'
)
BEGIN
    ALTER TABLE [MaintenanceIssues] ADD [Type] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417125835_AddAssetTracking'
)
BEGIN
    CREATE TABLE [AssetCategories] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(100) NOT NULL,
        [Prefix] nvarchar(10) NOT NULL,
        [NextSequenceNumber] int NOT NULL,
        [PaddingLength] int NOT NULL,
        [IsActive] bit NOT NULL,
        CONSTRAINT [PK_AssetCategories] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417125835_AddAssetTracking'
)
BEGIN
    CREATE TABLE [Assets] (
        [Id] int NOT NULL IDENTITY,
        [AssetTag] nvarchar(50) NOT NULL,
        [CategoryId] int NOT NULL,
        [Name] nvarchar(150) NOT NULL,
        [Manufacturer] nvarchar(max) NULL,
        [Model] nvarchar(max) NULL,
        [SerialNumber] nvarchar(max) NULL,
        [RoomId] int NULL,
        [Status] int NOT NULL,
        [RequiresPAT] bit NOT NULL,
        [RequiresLOLER] bit NOT NULL,
        [LastPATDate] datetime2 NULL,
        [NextPATDue] datetime2 NULL,
        [LastLOLERDate] datetime2 NULL,
        [NextLOLERDue] datetime2 NULL,
        CONSTRAINT [PK_Assets] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Assets_AssetCategories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [AssetCategories] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Assets_Rooms_RoomId] FOREIGN KEY ([RoomId]) REFERENCES [Rooms] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417125835_AddAssetTracking'
)
BEGIN
    CREATE TABLE [InspectionLogs] (
        [Id] int NOT NULL IDENTITY,
        [AssetId] int NOT NULL,
        [InspectionType] nvarchar(50) NOT NULL,
        [DateTested] datetime2 NOT NULL,
        [Passed] bit NOT NULL,
        [TestedBy] nvarchar(max) NULL,
        [Notes] nvarchar(max) NULL,
        CONSTRAINT [PK_InspectionLogs] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InspectionLogs_Assets_AssetId] FOREIGN KEY ([AssetId]) REFERENCES [Assets] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417125835_AddAssetTracking'
)
BEGIN
    CREATE INDEX [IX_MaintenanceIssues_AssetId] ON [MaintenanceIssues] ([AssetId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417125835_AddAssetTracking'
)
BEGIN
    CREATE INDEX [IX_Assets_CategoryId] ON [Assets] ([CategoryId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417125835_AddAssetTracking'
)
BEGIN
    CREATE INDEX [IX_Assets_RoomId] ON [Assets] ([RoomId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417125835_AddAssetTracking'
)
BEGIN
    CREATE INDEX [IX_InspectionLogs_AssetId] ON [InspectionLogs] ([AssetId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417125835_AddAssetTracking'
)
BEGIN
    ALTER TABLE [MaintenanceIssues] ADD CONSTRAINT [FK_MaintenanceIssues_Assets_AssetId] FOREIGN KEY ([AssetId]) REFERENCES [Assets] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417125835_AddAssetTracking'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417125835_AddAssetTracking', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417132957_AddAssetInsuranceAndOffsite'
)
BEGIN
    ALTER TABLE [Assets] ADD [AssignedTo] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417132957_AddAssetInsuranceAndOffsite'
)
BEGIN
    ALTER TABLE [Assets] ADD [IsOffsite] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417132957_AddAssetInsuranceAndOffsite'
)
BEGIN
    ALTER TABLE [Assets] ADD [ReplacementCost] decimal(18,2) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417132957_AddAssetInsuranceAndOffsite'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417132957_AddAssetInsuranceAndOffsite', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417140634_AddModuleToggles'
)
BEGIN
    ALTER TABLE [PortalConfigurations] ADD [IsAssetsEnabled] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417140634_AddModuleToggles'
)
BEGIN
    ALTER TABLE [PortalConfigurations] ADD [IsMaintenanceEnabled] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417140634_AddModuleToggles'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417140634_AddModuleToggles', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417144200_AddDetailedInspectionLogging'
)
BEGIN
    CREATE TABLE [InspectionRecord] (
        [Id] int NOT NULL IDENTITY,
        [AssetId] int NOT NULL,
        [InspectionDate] datetime2 NOT NULL,
        [InspectedBy] nvarchar(max) NOT NULL,
        [Type] int NOT NULL,
        [Status] int NOT NULL,
        [EarthBond] decimal(18,4) NULL,
        [Insulation] decimal(18,4) NULL,
        [Leakage] decimal(18,4) NULL,
        [Load] decimal(18,4) NULL,
        [Polarity] nvarchar(max) NULL,
        [Comments] nvarchar(max) NULL,
        [NextDueDate] datetime2 NOT NULL,
        [RawTestData] nvarchar(max) NULL,
        CONSTRAINT [PK_InspectionRecord] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InspectionRecord_Assets_AssetId] FOREIGN KEY ([AssetId]) REFERENCES [Assets] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417144200_AddDetailedInspectionLogging'
)
BEGIN
    CREATE INDEX [IX_InspectionRecord_AssetId] ON [InspectionRecord] ([AssetId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417144200_AddDetailedInspectionLogging'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417144200_AddDetailedInspectionLogging', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    ALTER TABLE [InspectionRecord] DROP CONSTRAINT [FK_InspectionRecord_Assets_AssetId];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    ALTER TABLE [InspectionRecord] DROP CONSTRAINT [PK_InspectionRecord];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    DECLARE @var16 nvarchar(max);
    SELECT @var16 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Assets]') AND [c].[name] = N'LastLOLERDate');
    IF @var16 IS NOT NULL EXEC(N'ALTER TABLE [Assets] DROP CONSTRAINT ' + @var16 + ';');
    ALTER TABLE [Assets] DROP COLUMN [LastLOLERDate];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    DECLARE @var17 nvarchar(max);
    SELECT @var17 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Assets]') AND [c].[name] = N'LastPATDate');
    IF @var17 IS NOT NULL EXEC(N'ALTER TABLE [Assets] DROP CONSTRAINT ' + @var17 + ';');
    ALTER TABLE [Assets] DROP COLUMN [LastPATDate];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    EXEC sp_rename N'[InspectionRecord]', N'InspectionRecords', 'OBJECT';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    EXEC sp_rename N'[InspectionRecords].[IX_InspectionRecord_AssetId]', N'IX_InspectionRecords_AssetId', 'INDEX';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    DECLARE @var18 nvarchar(max);
    SELECT @var18 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Rooms]') AND [c].[name] = N'Name');
    IF @var18 IS NOT NULL EXEC(N'ALTER TABLE [Rooms] DROP CONSTRAINT ' + @var18 + ';');
    ALTER TABLE [Rooms] ALTER COLUMN [Name] nvarchar(100) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    ALTER TABLE [Rooms] ADD [DefaultRisk] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    ALTER TABLE [Assets] ADD [ApplianceClass] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    ALTER TABLE [Assets] ADD [RetestIntervalOverride] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    ALTER TABLE [Assets] ADD [RiskOverride] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    ALTER TABLE [Assets] ADD [VisualOnly] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    DECLARE @var19 nvarchar(max);
    SELECT @var19 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Areas]') AND [c].[name] = N'Name');
    IF @var19 IS NOT NULL EXEC(N'ALTER TABLE [Areas] DROP CONSTRAINT ' + @var19 + ';');
    ALTER TABLE [Areas] ALTER COLUMN [Name] nvarchar(100) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    ALTER TABLE [InspectionRecords] ADD CONSTRAINT [PK_InspectionRecords] PRIMARY KEY ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    ALTER TABLE [InspectionRecords] ADD CONSTRAINT [FK_InspectionRecords_Assets_AssetId] FOREIGN KEY ([AssetId]) REFERENCES [Assets] ([Id]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417155102_FinalMergedApolloSchema'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417155102_FinalMergedApolloSchema', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    DECLARE @var20 nvarchar(max);
    SELECT @var20 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Suppliers]') AND [c].[name] = N'Phone');
    IF @var20 IS NOT NULL EXEC(N'ALTER TABLE [Suppliers] DROP CONSTRAINT ' + @var20 + ';');
    ALTER TABLE [Suppliers] ALTER COLUMN [Phone] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    DECLARE @var21 nvarchar(max);
    SELECT @var21 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Suppliers]') AND [c].[name] = N'Name');
    IF @var21 IS NOT NULL EXEC(N'ALTER TABLE [Suppliers] DROP CONSTRAINT ' + @var21 + ';');
    ALTER TABLE [Suppliers] ALTER COLUMN [Name] nvarchar(max) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    DECLARE @var22 nvarchar(max);
    SELECT @var22 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Suppliers]') AND [c].[name] = N'Email');
    IF @var22 IS NOT NULL EXEC(N'ALTER TABLE [Suppliers] DROP CONSTRAINT ' + @var22 + ';');
    ALTER TABLE [Suppliers] ALTER COLUMN [Email] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    DECLARE @var23 nvarchar(max);
    SELECT @var23 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Suppliers]') AND [c].[name] = N'Address');
    IF @var23 IS NOT NULL EXEC(N'ALTER TABLE [Suppliers] DROP CONSTRAINT ' + @var23 + ';');
    ALTER TABLE [Suppliers] ALTER COLUMN [Address] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    DECLARE @var24 nvarchar(max);
    SELECT @var24 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Signatories]') AND [c].[name] = N'Name');
    IF @var24 IS NOT NULL EXEC(N'ALTER TABLE [Signatories] DROP CONSTRAINT ' + @var24 + ';');
    ALTER TABLE [Signatories] ALTER COLUMN [Name] nvarchar(max) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    DECLARE @var25 nvarchar(max);
    SELECT @var25 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Signatories]') AND [c].[name] = N'ContactInfo');
    IF @var25 IS NOT NULL EXEC(N'ALTER TABLE [Signatories] DROP CONSTRAINT ' + @var25 + ';');
    ALTER TABLE [Signatories] ALTER COLUMN [ContactInfo] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    DECLARE @var26 nvarchar(max);
    SELECT @var26 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Locks]') AND [c].[name] = N'KeyCode');
    IF @var26 IS NOT NULL EXEC(N'ALTER TABLE [Locks] DROP CONSTRAINT ' + @var26 + ';');
    ALTER TABLE [Locks] ALTER COLUMN [KeyCode] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    DECLARE @var27 nvarchar(max);
    SELECT @var27 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Keys]') AND [c].[name] = N'IssuedToName');
    IF @var27 IS NOT NULL EXEC(N'ALTER TABLE [Keys] DROP CONSTRAINT ' + @var27 + ';');
    ALTER TABLE [Keys] ALTER COLUMN [IssuedToName] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    ALTER TABLE [InspectionRecords] ADD [EarthBondPassed] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    ALTER TABLE [InspectionRecords] ADD [ExaminedComponents] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    ALTER TABLE [InspectionRecords] ADD [InsulationPassed] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    ALTER TABLE [InspectionRecords] ADD [LeakagePassed] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    ALTER TABLE [InspectionRecords] ADD [PolarityPassed] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    ALTER TABLE [InspectionRecords] ADD [WeightTestPerformed] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    DECLARE @var28 nvarchar(max);
    SELECT @var28 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[CheckoutTransactions]') AND [c].[name] = N'IssuedToName');
    IF @var28 IS NOT NULL EXEC(N'ALTER TABLE [CheckoutTransactions] DROP CONSTRAINT ' + @var28 + ';');
    ALTER TABLE [CheckoutTransactions] ALTER COLUMN [IssuedToName] nvarchar(max) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    DECLARE @var29 nvarchar(max);
    SELECT @var29 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AuditLogs]') AND [c].[name] = N'TableName');
    IF @var29 IS NOT NULL EXEC(N'ALTER TABLE [AuditLogs] DROP CONSTRAINT ' + @var29 + ';');
    ALTER TABLE [AuditLogs] ALTER COLUMN [TableName] nvarchar(max) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    DECLARE @var30 nvarchar(max);
    SELECT @var30 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AuditLogs]') AND [c].[name] = N'ActionType');
    IF @var30 IS NOT NULL EXEC(N'ALTER TABLE [AuditLogs] DROP CONSTRAINT ' + @var30 + ';');
    ALTER TABLE [AuditLogs] ALTER COLUMN [ActionType] nvarchar(max) NOT NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    ALTER TABLE [Assets] ADD [LastWeightTestDate] datetime2 NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    ALTER TABLE [Assets] ADD [SWL] nvarchar(50) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260417165426_AddLolerSpec'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260417165426_AddLolerSpec', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418130132_AddMembersTable'
)
BEGIN
    CREATE TABLE [Members] (
        [Id] int NOT NULL IDENTITY,
        [MemberNumber] nvarchar(max) NOT NULL,
        [FirstName] nvarchar(max) NOT NULL,
        [LastName] nvarchar(max) NOT NULL,
        [Email] nvarchar(max) NULL,
        [MobileNumber] nvarchar(max) NULL,
        [MembershipStatus] nvarchar(max) NOT NULL,
        [ExpiryDate] datetime2 NULL,
        [IsFirstAider] bit NOT NULL,
        [HasDBS] bit NOT NULL,
        [IsTechTeam] bit NOT NULL,
        [SkillActing] bit NOT NULL,
        [SkillDirector] bit NOT NULL,
        [SkillLXDesign] bit NOT NULL,
        [SkillLXOp] bit NOT NULL,
        [SkillSoundDesign] bit NOT NULL,
        [SkillSoundOp] bit NOT NULL,
        [SkillStageManager] bit NOT NULL,
        [SkillStageCrew] bit NOT NULL,
        [SkillWardrobe] bit NOT NULL,
        [SkillSetBuild] bit NOT NULL,
        [SkillFOH] bit NOT NULL,
        [SkillBar] bit NOT NULL,
        CONSTRAINT [PK_Members] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418130132_AddMembersTable'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418130132_AddMembersTable', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133024_AddProductionHub'
)
BEGIN
    CREATE TABLE [ProductionRoles] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [Category] int NOT NULL,
        [IsMandatory] bit NOT NULL,
        [LinkedKeyBunchId] int NULL,
        CONSTRAINT [PK_ProductionRoles] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133024_AddProductionHub'
)
BEGIN
    CREATE TABLE [Productions] (
        [Id] int NOT NULL IDENTITY,
        [Title] nvarchar(max) NOT NULL,
        [Type] int NOT NULL,
        [StartDate] datetime2 NOT NULL,
        [EndDate] datetime2 NOT NULL,
        [TicketSourceId] nvarchar(max) NULL,
        [HirerName] nvarchar(max) NULL,
        [HirerContact] nvarchar(max) NULL,
        [AccessTime] datetime2 NULL,
        [TechRequirements] nvarchar(max) NULL,
        [RequiresProjection] bit NOT NULL,
        [OurCrew] bit NOT NULL,
        [UnlockingMemberId] int NULL,
        [LockingMemberId] int NULL,
        [InternalNotes] nvarchar(max) NULL,
        [DriveLink] nvarchar(max) NULL,
        CONSTRAINT [PK_Productions] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Productions_Members_LockingMemberId] FOREIGN KEY ([LockingMemberId]) REFERENCES [Members] ([Id]),
        CONSTRAINT [FK_Productions_Members_UnlockingMemberId] FOREIGN KEY ([UnlockingMemberId]) REFERENCES [Members] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133024_AddProductionHub'
)
BEGIN
    CREATE TABLE [ProductionCredits] (
        [Id] int NOT NULL IDENTITY,
        [ProductionId] int NOT NULL,
        [Label] nvarchar(max) NOT NULL,
        [Value] nvarchar(max) NOT NULL,
        [DisplayOrder] int NOT NULL,
        CONSTRAINT [PK_ProductionCredits] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ProductionCredits_Productions_ProductionId] FOREIGN KEY ([ProductionId]) REFERENCES [Productions] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133024_AddProductionHub'
)
BEGIN
    CREATE TABLE [ProductionCrews] (
        [Id] int NOT NULL IDENTITY,
        [ProductionId] int NOT NULL,
        [RoleId] int NOT NULL,
        [MemberId] int NULL,
        [ExternalName] nvarchar(max) NULL,
        [IsFullRun] bit NOT NULL,
        [RotaNotes] nvarchar(max) NULL,
        CONSTRAINT [PK_ProductionCrews] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ProductionCrews_Members_MemberId] FOREIGN KEY ([MemberId]) REFERENCES [Members] ([Id]),
        CONSTRAINT [FK_ProductionCrews_ProductionRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [ProductionRoles] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_ProductionCrews_Productions_ProductionId] FOREIGN KEY ([ProductionId]) REFERENCES [Productions] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133024_AddProductionHub'
)
BEGIN
    CREATE INDEX [IX_ProductionCredits_ProductionId] ON [ProductionCredits] ([ProductionId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133024_AddProductionHub'
)
BEGIN
    CREATE INDEX [IX_ProductionCrews_MemberId] ON [ProductionCrews] ([MemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133024_AddProductionHub'
)
BEGIN
    CREATE INDEX [IX_ProductionCrews_ProductionId] ON [ProductionCrews] ([ProductionId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133024_AddProductionHub'
)
BEGIN
    CREATE INDEX [IX_ProductionCrews_RoleId] ON [ProductionCrews] ([RoleId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133024_AddProductionHub'
)
BEGIN
    CREATE INDEX [IX_Productions_LockingMemberId] ON [Productions] ([LockingMemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133024_AddProductionHub'
)
BEGIN
    CREATE INDEX [IX_Productions_UnlockingMemberId] ON [Productions] ([UnlockingMemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133024_AddProductionHub'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418133024_AddProductionHub', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133628_AddIsRequiredToCrew'
)
BEGIN
    ALTER TABLE [ProductionCrews] ADD [IsRequired] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418133628_AddIsRequiredToCrew'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418133628_AddIsRequiredToCrew', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418135930_ProductionDetails'
)
BEGIN
    ALTER TABLE [ProductionCrews] DROP CONSTRAINT [FK_ProductionCrews_ProductionRoles_RoleId];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418135930_ProductionDetails'
)
BEGIN
    EXEC sp_rename N'[ProductionCrews].[RotaNotes]', N'CustomRoleName', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418135930_ProductionDetails'
)
BEGIN
    DECLARE @var31 nvarchar(max);
    SELECT @var31 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ProductionCrews]') AND [c].[name] = N'RoleId');
    IF @var31 IS NOT NULL EXEC(N'ALTER TABLE [ProductionCrews] DROP CONSTRAINT ' + @var31 + ';');
    ALTER TABLE [ProductionCrews] ALTER COLUMN [RoleId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418135930_ProductionDetails'
)
BEGIN
    CREATE TABLE [ProductionEventTypes] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_ProductionEventTypes] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418135930_ProductionDetails'
)
BEGIN
    CREATE TABLE [ProductionEvents] (
        [Id] int NOT NULL IDENTITY,
        [ProductionId] int NOT NULL,
        [EventTypeId] int NOT NULL,
        [EventDate] datetime2 NOT NULL,
        [Notes] nvarchar(max) NULL,
        CONSTRAINT [PK_ProductionEvents] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ProductionEvents_ProductionEventTypes_EventTypeId] FOREIGN KEY ([EventTypeId]) REFERENCES [ProductionEventTypes] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418135930_ProductionDetails'
)
BEGIN
    CREATE INDEX [IX_ProductionEvents_EventTypeId] ON [ProductionEvents] ([EventTypeId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418135930_ProductionDetails'
)
BEGIN
    ALTER TABLE [ProductionCrews] ADD CONSTRAINT [FK_ProductionCrews_ProductionRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [ProductionRoles] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418135930_ProductionDetails'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418135930_ProductionDetails', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418142609_DynamicProductionHub'
)
BEGIN
    DECLARE @var32 nvarchar(max);
    SELECT @var32 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Productions]') AND [c].[name] = N'RequiresProjection');
    IF @var32 IS NOT NULL EXEC(N'ALTER TABLE [Productions] DROP CONSTRAINT ' + @var32 + ';');
    ALTER TABLE [Productions] DROP COLUMN [RequiresProjection];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418142609_DynamicProductionHub'
)
BEGIN
    EXEC sp_rename N'[Productions].[Type]', N'CategoryId', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418142609_DynamicProductionHub'
)
BEGIN
    EXEC sp_rename N'[ProductionRoles].[Category]', N'CategoryId', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418142609_DynamicProductionHub'
)
BEGIN
    CREATE TABLE [ProductionCategories] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [IconClass] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_ProductionCategories] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418142609_DynamicProductionHub'
)
BEGIN
    CREATE INDEX [IX_Productions_CategoryId] ON [Productions] ([CategoryId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418142609_DynamicProductionHub'
)
BEGIN
    CREATE INDEX [IX_ProductionRoles_CategoryId] ON [ProductionRoles] ([CategoryId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418142609_DynamicProductionHub'
)
BEGIN
    CREATE INDEX [IX_ProductionEvents_ProductionId] ON [ProductionEvents] ([ProductionId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418142609_DynamicProductionHub'
)
BEGIN
    ALTER TABLE [ProductionEvents] ADD CONSTRAINT [FK_ProductionEvents_Productions_ProductionId] FOREIGN KEY ([ProductionId]) REFERENCES [Productions] ([Id]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418142609_DynamicProductionHub'
)
BEGIN
    ALTER TABLE [ProductionRoles] ADD CONSTRAINT [FK_ProductionRoles_ProductionCategories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [ProductionCategories] ([Id]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418142609_DynamicProductionHub'
)
BEGIN
    ALTER TABLE [Productions] ADD CONSTRAINT [FK_Productions_ProductionCategories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [ProductionCategories] ([Id]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418142609_DynamicProductionHub'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418142609_DynamicProductionHub', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418163817_PerformanceInfo'
)
BEGIN
    CREATE TABLE [Performances] (
        [Id] int NOT NULL IDENTITY,
        [ProductionId] int NOT NULL,
        [CurtainUp] datetime2 NOT NULL,
        [PerformanceTitle] nvarchar(max) NULL,
        [ScheduleNotes] nvarchar(max) NULL,
        CONSTRAINT [PK_Performances] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418163817_PerformanceInfo'
)
BEGIN
    CREATE TABLE [PerformanceCrewOverride] (
        [Id] int NOT NULL IDENTITY,
        [PerformanceId] int NOT NULL,
        [RoleId] int NOT NULL,
        [MemberId] int NULL,
        [ExternalName] nvarchar(max) NULL,
        CONSTRAINT [PK_PerformanceCrewOverride] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_PerformanceCrewOverride_Performances_PerformanceId] FOREIGN KEY ([PerformanceId]) REFERENCES [Performances] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418163817_PerformanceInfo'
)
BEGIN
    CREATE INDEX [IX_PerformanceCrewOverride_PerformanceId] ON [PerformanceCrewOverride] ([PerformanceId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418163817_PerformanceInfo'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418163817_PerformanceInfo', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418164057_PerformanceInfo2'
)
BEGIN
    ALTER TABLE [PerformanceCrewOverride] DROP CONSTRAINT [FK_PerformanceCrewOverride_Performances_PerformanceId];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418164057_PerformanceInfo2'
)
BEGIN
    ALTER TABLE [PerformanceCrewOverride] DROP CONSTRAINT [PK_PerformanceCrewOverride];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418164057_PerformanceInfo2'
)
BEGIN
    EXEC sp_rename N'[PerformanceCrewOverride]', N'PerformanceCrewOverrides', 'OBJECT';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418164057_PerformanceInfo2'
)
BEGIN
    EXEC sp_rename N'[PerformanceCrewOverrides].[IX_PerformanceCrewOverride_PerformanceId]', N'IX_PerformanceCrewOverrides_PerformanceId', 'INDEX';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418164057_PerformanceInfo2'
)
BEGIN
    ALTER TABLE [PerformanceCrewOverrides] ADD CONSTRAINT [PK_PerformanceCrewOverrides] PRIMARY KEY ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418164057_PerformanceInfo2'
)
BEGIN
    ALTER TABLE [PerformanceCrewOverrides] ADD CONSTRAINT [FK_PerformanceCrewOverrides_Performances_PerformanceId] FOREIGN KEY ([PerformanceId]) REFERENCES [Performances] ([Id]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418164057_PerformanceInfo2'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418164057_PerformanceInfo2', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418165253_AddCategoryExternalFlag'
)
BEGIN
    ALTER TABLE [ProductionCategories] ADD [IsExternal] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418165253_AddCategoryExternalFlag'
)
BEGIN
    DECLARE @var33 nvarchar(max);
    SELECT @var33 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[PerformanceCrewOverrides]') AND [c].[name] = N'RoleId');
    IF @var33 IS NOT NULL EXEC(N'ALTER TABLE [PerformanceCrewOverrides] DROP CONSTRAINT ' + @var33 + ';');
    ALTER TABLE [PerformanceCrewOverrides] ALTER COLUMN [RoleId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418165253_AddCategoryExternalFlag'
)
BEGIN
    ALTER TABLE [PerformanceCrewOverrides] ADD [CustomRoleName] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418165253_AddCategoryExternalFlag'
)
BEGIN
    CREATE INDEX [IX_PerformanceCrewOverrides_MemberId] ON [PerformanceCrewOverrides] ([MemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418165253_AddCategoryExternalFlag'
)
BEGIN
    CREATE INDEX [IX_PerformanceCrewOverrides_RoleId] ON [PerformanceCrewOverrides] ([RoleId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418165253_AddCategoryExternalFlag'
)
BEGIN
    ALTER TABLE [PerformanceCrewOverrides] ADD CONSTRAINT [FK_PerformanceCrewOverrides_Members_MemberId] FOREIGN KEY ([MemberId]) REFERENCES [Members] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418165253_AddCategoryExternalFlag'
)
BEGIN
    ALTER TABLE [PerformanceCrewOverrides] ADD CONSTRAINT [FK_PerformanceCrewOverrides_ProductionRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [ProductionRoles] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418165253_AddCategoryExternalFlag'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418165253_AddCategoryExternalFlag', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418173716_AddReportNavigationProperties'
)
BEGIN
    CREATE INDEX [IX_Performances_ProductionId] ON [Performances] ([ProductionId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418173716_AddReportNavigationProperties'
)
BEGIN
    ALTER TABLE [Performances] ADD CONSTRAINT [FK_Performances_Productions_ProductionId] FOREIGN KEY ([ProductionId]) REFERENCES [Productions] ([Id]) ON DELETE CASCADE;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418173716_AddReportNavigationProperties'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418173716_AddReportNavigationProperties', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418174824_AddFOHFields'
)
BEGIN
    ALTER TABLE [Productions] ADD [ContentWarnings] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418174824_AddFOHFields'
)
BEGIN
    ALTER TABLE [Productions] ADD [FOHNotes] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418174824_AddFOHFields'
)
BEGIN
    ALTER TABLE [Productions] ADD [IntervalMinutes] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418174824_AddFOHFields'
)
BEGIN
    ALTER TABLE [Productions] ADD [RunningTimeMinutes] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418174824_AddFOHFields'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418174824_AddFOHFields', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418175233_AddFoHAndProdReportsFields'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418175233_AddFoHAndProdReportsFields', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418193248_AddHandSModule'
)
BEGIN
    CREATE TABLE [CoshhSubstances] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [Manufacturer] nvarchar(max) NULL,
        [MsdsFilePath] nvarchar(max) NULL,
        [MsdsExpiry] datetime2 NULL,
        [HazardPictograms] nvarchar(max) NULL,
        [UseInstructions] nvarchar(max) NULL,
        CONSTRAINT [PK_CoshhSubstances] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418193248_AddHandSModule'
)
BEGIN
    CREATE TABLE [FireSystemComponents] (
        [Id] int NOT NULL IDENTITY,
        [UniqueID] nvarchar(max) NOT NULL,
        [Type] nvarchar(max) NOT NULL,
        [IsMaintained] bit NOT NULL,
        [RoomId] int NOT NULL,
        [SpecificLocation] nvarchar(max) NULL,
        [LastTested] datetime2 NULL,
        [IsActive] bit NOT NULL,
        CONSTRAINT [PK_FireSystemComponents] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_FireSystemComponents_Rooms_RoomId] FOREIGN KEY ([RoomId]) REFERENCES [Rooms] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418193248_AddHandSModule'
)
BEGIN
    CREATE TABLE [IncidentRecords] (
        [Id] int NOT NULL IDENTITY,
        [Timestamp] datetime2 NOT NULL,
        [Severity] int NOT NULL,
        [Description] nvarchar(max) NOT NULL,
        [PersonsInvolved] nvarchar(max) NULL,
        [TreatmentGiven] nvarchar(max) NULL,
        [RoomId] int NULL,
        [IsRiddorReportable] bit NOT NULL,
        [RiddorReportedDate] datetime2 NULL,
        CONSTRAINT [PK_IncidentRecords] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_IncidentRecords_Rooms_RoomId] FOREIGN KEY ([RoomId]) REFERENCES [Rooms] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418193248_AddHandSModule'
)
BEGIN
    CREATE TABLE [RiskAssessments] (
        [Id] int NOT NULL IDENTITY,
        [Title] nvarchar(max) NOT NULL,
        [Type] int NOT NULL,
        [ProductionId] int NULL,
        [AreaId] int NULL,
        [AssessedBy] nvarchar(max) NULL,
        [AssessmentDate] datetime2 NOT NULL,
        [ReviewDueDate] datetime2 NOT NULL,
        [IsApproved] bit NOT NULL,
        [ApprovedBy] nvarchar(max) NULL,
        CONSTRAINT [PK_RiskAssessments] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RiskAssessments_Areas_AreaId] FOREIGN KEY ([AreaId]) REFERENCES [Areas] ([Id]),
        CONSTRAINT [FK_RiskAssessments_Productions_ProductionId] FOREIGN KEY ([ProductionId]) REFERENCES [Productions] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418193248_AddHandSModule'
)
BEGIN
    CREATE TABLE [RAHazards] (
        [Id] int NOT NULL IDENTITY,
        [RiskAssessmentId] int NOT NULL,
        [HazardName] nvarchar(max) NOT NULL,
        [WhoIsAtRisk] nvarchar(max) NULL,
        [InitialLikelihood] int NOT NULL,
        [InitialSeverity] int NOT NULL,
        [MitigationMeasures] nvarchar(max) NULL,
        [ResidualLikelihood] int NOT NULL,
        [ResidualSeverity] int NOT NULL,
        CONSTRAINT [PK_RAHazards] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RAHazards_RiskAssessments_RiskAssessmentId] FOREIGN KEY ([RiskAssessmentId]) REFERENCES [RiskAssessments] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418193248_AddHandSModule'
)
BEGIN
    CREATE INDEX [IX_FireSystemComponents_RoomId] ON [FireSystemComponents] ([RoomId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418193248_AddHandSModule'
)
BEGIN
    CREATE INDEX [IX_IncidentRecords_RoomId] ON [IncidentRecords] ([RoomId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418193248_AddHandSModule'
)
BEGIN
    CREATE INDEX [IX_RAHazards_RiskAssessmentId] ON [RAHazards] ([RiskAssessmentId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418193248_AddHandSModule'
)
BEGIN
    CREATE INDEX [IX_RiskAssessments_AreaId] ON [RiskAssessments] ([AreaId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418193248_AddHandSModule'
)
BEGIN
    CREATE INDEX [IX_RiskAssessments_ProductionId] ON [RiskAssessments] ([ProductionId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418193248_AddHandSModule'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418193248_AddHandSModule', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418201110_AddHSFormalReviews'
)
BEGIN
    CREATE TABLE [CoshhAssessments] (
        [Id] int NOT NULL IDENTITY,
        [SubstanceId] int NOT NULL,
        [TaskDescription] nvarchar(max) NOT NULL,
        [RoomId] int NULL,
        [ControlMeasures] nvarchar(max) NOT NULL,
        [PPE_Required] nvarchar(max) NOT NULL,
        [DisposalInstructions] nvarchar(max) NOT NULL,
        [AssessmentDate] datetime2 NOT NULL,
        [ReviewDueDate] datetime2 NOT NULL,
        [IsApproved] bit NOT NULL,
        CONSTRAINT [PK_CoshhAssessments] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_CoshhAssessments_CoshhSubstances_SubstanceId] FOREIGN KEY ([SubstanceId]) REFERENCES [CoshhSubstances] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_CoshhAssessments_Rooms_RoomId] FOREIGN KEY ([RoomId]) REFERENCES [Rooms] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418201110_AddHSFormalReviews'
)
BEGIN
    CREATE TABLE [FireRiskAssessmentDetails] (
        [Id] int NOT NULL IDENTITY,
        [RiskAssessmentId] int NOT NULL,
        [Step1_IgnitionSources] nvarchar(max) NOT NULL,
        [Step1_FuelSources] nvarchar(max) NOT NULL,
        [Step2_PeopleAtRisk] nvarchar(max) NOT NULL,
        [Step3_EvaluationNotes] nvarchar(max) NOT NULL,
        [Step4_RecordPlanTrain] nvarchar(max) NOT NULL,
        [MaxOccupancy] int NOT NULL,
        [FireCurtainTested] bit NOT NULL,
        [ExitRoutesStatus] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_FireRiskAssessmentDetails] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_FireRiskAssessmentDetails_RiskAssessments_RiskAssessmentId] FOREIGN KEY ([RiskAssessmentId]) REFERENCES [RiskAssessments] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418201110_AddHSFormalReviews'
)
BEGIN
    CREATE TABLE [RiskAssessmentReviews] (
        [Id] int NOT NULL IDENTITY,
        [RiskAssessmentId] int NOT NULL,
        [ReviewDate] datetime2 NOT NULL,
        [ReviewedBy] nvarchar(max) NOT NULL,
        [ReviewOutcome] nvarchar(max) NOT NULL,
        [Comments] nvarchar(max) NULL,
        [NextReviewDueDate] datetime2 NOT NULL,
        CONSTRAINT [PK_RiskAssessmentReviews] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RiskAssessmentReviews_RiskAssessments_RiskAssessmentId] FOREIGN KEY ([RiskAssessmentId]) REFERENCES [RiskAssessments] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418201110_AddHSFormalReviews'
)
BEGIN
    CREATE INDEX [IX_CoshhAssessments_RoomId] ON [CoshhAssessments] ([RoomId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418201110_AddHSFormalReviews'
)
BEGIN
    CREATE INDEX [IX_CoshhAssessments_SubstanceId] ON [CoshhAssessments] ([SubstanceId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418201110_AddHSFormalReviews'
)
BEGIN
    CREATE INDEX [IX_FireRiskAssessmentDetails_RiskAssessmentId] ON [FireRiskAssessmentDetails] ([RiskAssessmentId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418201110_AddHSFormalReviews'
)
BEGIN
    CREATE INDEX [IX_RiskAssessmentReviews_RiskAssessmentId] ON [RiskAssessmentReviews] ([RiskAssessmentId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418201110_AddHSFormalReviews'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418201110_AddHSFormalReviews', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418201945_AddCOSHH'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418201945_AddCOSHH', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [ConstructionDetails] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Discriminator] nvarchar(21) NOT NULL DEFAULT N'';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [MaxOccupancy] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Narrative_EvaluationNotes] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Narrative_HazardsFound] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Narrative_PeopleAtRisk] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [NumberOfFloors] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Arson_Secure] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Arson_WasteSafe] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Contractors_Qualified] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Cook_Safe] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Elec_ApplianceTested] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Elec_FixedInspected] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Elec_NoAdapters] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Escape_ExitsOpenable] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Escape_Obstructions] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Heat_Maintenance] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Housekeeping_Clear] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Manage_Training] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Smoke_MeasuresInPlace] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Smoke_SignageProvided] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Warning_AlarmSuitable] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Q_Warning_DetectorsAdequate] bit NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [UseOfPremises] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    CREATE TABLE [FireActionPlanItems] (
        [Id] int NOT NULL IDENTITY,
        [FireRiskAssessmentId] int NOT NULL,
        [ItemName] nvarchar(max) NOT NULL,
        [Deficiency] nvarchar(max) NOT NULL,
        [ProposedAction] nvarchar(max) NOT NULL,
        [Timescale] nvarchar(max) NOT NULL,
        [PersonResponsible] nvarchar(max) NOT NULL,
        [IsCompleted] bit NOT NULL,
        CONSTRAINT [PK_FireActionPlanItems] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_FireActionPlanItems_RiskAssessments_FireRiskAssessmentId] FOREIGN KEY ([FireRiskAssessmentId]) REFERENCES [RiskAssessments] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    CREATE TABLE [RoomFireSafetyAssignments] (
        [Id] int NOT NULL IDENTITY,
        [FireRiskAssessmentId] int NOT NULL,
        [RoomId] int NOT NULL,
        [IsCoveredByAreaAssessment] bit NOT NULL,
        [ExceptionNote] nvarchar(max) NULL,
        CONSTRAINT [PK_RoomFireSafetyAssignments] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_RoomFireSafetyAssignments_RiskAssessments_FireRiskAssessmentId] FOREIGN KEY ([FireRiskAssessmentId]) REFERENCES [RiskAssessments] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_RoomFireSafetyAssignments_Rooms_RoomId] FOREIGN KEY ([RoomId]) REFERENCES [Rooms] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    CREATE INDEX [IX_FireActionPlanItems_FireRiskAssessmentId] ON [FireActionPlanItems] ([FireRiskAssessmentId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    CREATE INDEX [IX_RoomFireSafetyAssignments_FireRiskAssessmentId] ON [RoomFireSafetyAssignments] ([FireRiskAssessmentId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    CREATE INDEX [IX_RoomFireSafetyAssignments_RoomId] ON [RoomFireSafetyAssignments] ([RoomId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418205353_AdditionalFSRAReqs'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418205353_AdditionalFSRAReqs', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418210301_FSRANarrativeFields'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Narrative_FuelSources] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418210301_FSRANarrativeFields'
)
BEGIN
    ALTER TABLE [RiskAssessments] ADD [Narrative_IgnitionSources] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260418210301_FSRANarrativeFields'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260418210301_FSRANarrativeFields', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260419171605_AddFireActionPlanItem'
)
BEGIN
    ALTER TABLE [FireActionPlanItems] ADD [IsResolved] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260419171605_AddFireActionPlanItem'
)
BEGIN
    ALTER TABLE [FireActionPlanItems] ADD [ResolutionNotes] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260419171605_AddFireActionPlanItem'
)
BEGIN
    ALTER TABLE [FireActionPlanItems] ADD [ResolvedBy] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260419171605_AddFireActionPlanItem'
)
BEGIN
    ALTER TABLE [FireActionPlanItems] ADD [ResolvedDate] datetime2 NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260419171605_AddFireActionPlanItem'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260419171605_AddFireActionPlanItem', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421184558_EnhanceCoshhWithSignoff'
)
BEGIN
    ALTER TABLE [CoshhAssessments] ADD [ApprovedBy] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421184558_EnhanceCoshhWithSignoff'
)
BEGIN
    ALTER TABLE [CoshhAssessments] ADD [FirstAidMeasures] nvarchar(max) NOT NULL DEFAULT N'';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421184558_EnhanceCoshhWithSignoff'
)
BEGIN
    ALTER TABLE [CoshhAssessments] ADD [HealthRisks] nvarchar(max) NOT NULL DEFAULT N'';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421184558_EnhanceCoshhWithSignoff'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260421184558_EnhanceCoshhWithSignoff', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    DECLARE @var34 nvarchar(max);
    SELECT @var34 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[IncidentRecords]') AND [c].[name] = N'IsRiddorReportable');
    IF @var34 IS NOT NULL EXEC(N'ALTER TABLE [IncidentRecords] DROP CONSTRAINT ' + @var34 + ';');
    ALTER TABLE [IncidentRecords] DROP COLUMN [IsRiddorReportable];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    EXEC sp_rename N'[IncidentRecords].[TreatmentGiven]', N'WitnessDetails', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    EXEC sp_rename N'[IncidentRecords].[Timestamp]', N'IncidentDateTime', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    EXEC sp_rename N'[IncidentRecords].[RiddorReportedDate]', N'DateClosed', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    EXEC sp_rename N'[IncidentRecords].[PersonsInvolved]', N'RootCause', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    EXEC sp_rename N'[IncidentRecords].[Description]', N'ReportedBy', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    ALTER TABLE [Rooms] ADD [SpecificAssemblyPoint] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    ALTER TABLE [IncidentRecords] ADD [DescriptionOfEvent] nvarchar(max) NOT NULL DEFAULT N'';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    ALTER TABLE [IncidentRecords] ADD [ImmediateActionTaken] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    ALTER TABLE [IncidentRecords] ADD [InjuriesSustained] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    ALTER TABLE [IncidentRecords] ADD [InvestigatedBy] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    ALTER TABLE [IncidentRecords] ADD [InvestigationFindings] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    ALTER TABLE [IncidentRecords] ADD [LinkedMaintenanceIssueId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    ALTER TABLE [IncidentRecords] ADD [PersonInvolvedName] nvarchar(max) NOT NULL DEFAULT N'';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    ALTER TABLE [IncidentRecords] ADD [PersonInvolvedType] nvarchar(max) NOT NULL DEFAULT N'';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    ALTER TABLE [IncidentRecords] ADD [Status] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    ALTER TABLE [IncidentRecords] ADD [Type] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    CREATE TABLE [ComplianceConfigurations] (
        [Id] int NOT NULL IDENTITY,
        [MainAssemblyPoint] nvarchar(max) NOT NULL,
        [EmergencyPhoneNumber] nvarchar(max) NOT NULL,
        [SiteAddress] nvarchar(max) NOT NULL,
        [RAWarningDays] int NOT NULL,
        [CoshhWarningDays] int NOT NULL,
        CONSTRAINT [PK_ComplianceConfigurations] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    CREATE TABLE [ContractorRAMS] (
        [Id] int NOT NULL IDENTITY,
        [SupplierId] int NOT NULL,
        [MaintenanceIssueId] int NULL,
        [DocumentTitle] nvarchar(max) NOT NULL,
        [FilePath] nvarchar(max) NOT NULL,
        [SubmissionDate] datetime2 NOT NULL,
        [ExpiryDate] datetime2 NOT NULL,
        [IsReviewed] bit NOT NULL,
        [ReviewedBy] nvarchar(max) NULL,
        [ApprovalNotes] nvarchar(max) NULL,
        CONSTRAINT [PK_ContractorRAMS] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ContractorRAMS_MaintenanceIssues_MaintenanceIssueId] FOREIGN KEY ([MaintenanceIssueId]) REFERENCES [MaintenanceIssues] ([Id]),
        CONSTRAINT [FK_ContractorRAMS_Suppliers_SupplierId] FOREIGN KEY ([SupplierId]) REFERENCES [Suppliers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    CREATE TABLE [IncidentEvidence] (
        [Id] int NOT NULL IDENTITY,
        [IncidentRecordId] int NOT NULL,
        [FilePath] nvarchar(max) NOT NULL,
        [Caption] nvarchar(max) NOT NULL,
        CONSTRAINT [PK_IncidentEvidence] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_IncidentEvidence_IncidentRecords_IncidentRecordId] FOREIGN KEY ([IncidentRecordId]) REFERENCES [IncidentRecords] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    CREATE INDEX [IX_ContractorRAMS_MaintenanceIssueId] ON [ContractorRAMS] ([MaintenanceIssueId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    CREATE INDEX [IX_ContractorRAMS_SupplierId] ON [ContractorRAMS] ([SupplierId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    CREATE INDEX [IX_IncidentEvidence_IncidentRecordId] ON [IncidentEvidence] ([IncidentRecordId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421195002_AddAccidentBook'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260421195002_AddAccidentBook', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421201800_HS_Consolidation_V4'
)
BEGIN
    DECLARE @var35 nvarchar(max);
    SELECT @var35 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RoomFireSafetyAssignments]') AND [c].[name] = N'ExceptionNote');
    IF @var35 IS NOT NULL EXEC(N'ALTER TABLE [RoomFireSafetyAssignments] DROP CONSTRAINT ' + @var35 + ';');
    ALTER TABLE [RoomFireSafetyAssignments] DROP COLUMN [ExceptionNote];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421201800_HS_Consolidation_V4'
)
BEGIN
    DECLARE @var36 nvarchar(max);
    SELECT @var36 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[RiskAssessments]') AND [c].[name] = N'Narrative_HazardsFound');
    IF @var36 IS NOT NULL EXEC(N'ALTER TABLE [RiskAssessments] DROP CONSTRAINT ' + @var36 + ';');
    ALTER TABLE [RiskAssessments] DROP COLUMN [Narrative_HazardsFound];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421201800_HS_Consolidation_V4'
)
BEGIN
    DECLARE @var37 nvarchar(max);
    SELECT @var37 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[FireActionPlanItems]') AND [c].[name] = N'IsCompleted');
    IF @var37 IS NOT NULL EXEC(N'ALTER TABLE [FireActionPlanItems] DROP CONSTRAINT ' + @var37 + ';');
    ALTER TABLE [FireActionPlanItems] DROP COLUMN [IsCompleted];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421201800_HS_Consolidation_V4'
)
BEGIN
    ALTER TABLE [IncidentRecords] ADD [EntryMethod] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260421201800_HS_Consolidation_V4'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260421201800_HS_Consolidation_V4', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823090146_AddProductionSortAndDep'
)
BEGIN
    ALTER TABLE [ProductionCrews] ADD [DepMemberId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823090146_AddProductionSortAndDep'
)
BEGIN
    ALTER TABLE [ProductionCategories] ADD [SortOrder] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823090146_AddProductionSortAndDep'
)
BEGIN
    CREATE INDEX [IX_ProductionCrews_DepMemberId] ON [ProductionCrews] ([DepMemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823090146_AddProductionSortAndDep'
)
BEGIN
    ALTER TABLE [ProductionCrews] ADD CONSTRAINT [FK_ProductionCrews_Members_DepMemberId] FOREIGN KEY ([DepMemberId]) REFERENCES [Members] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823090146_AddProductionSortAndDep'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260823090146_AddProductionSortAndDep', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823091712_AddProductionCastAndContactOverrides'
)
BEGIN
    DECLARE @var38 nvarchar(max);
    SELECT @var38 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ProductionCrews]') AND [c].[name] = N'IsFullRun');
    IF @var38 IS NOT NULL EXEC(N'ALTER TABLE [ProductionCrews] DROP CONSTRAINT ' + @var38 + ';');
    ALTER TABLE [ProductionCrews] DROP COLUMN [IsFullRun];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823091712_AddProductionCastAndContactOverrides'
)
BEGIN
    ALTER TABLE [ProductionCrews] ADD [CustomContactNumber] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823091712_AddProductionCastAndContactOverrides'
)
BEGIN
    CREATE TABLE [ProductionCasts] (
        [Id] int NOT NULL IDENTITY,
        [ProductionId] int NOT NULL,
        [CharacterName] nvarchar(max) NOT NULL,
        [MemberId] int NULL,
        [DepMemberId] int NULL,
        [ExternalName] nvarchar(max) NULL,
        [CustomContactNumber] nvarchar(max) NULL,
        CONSTRAINT [PK_ProductionCasts] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ProductionCasts_Members_DepMemberId] FOREIGN KEY ([DepMemberId]) REFERENCES [Members] ([Id]),
        CONSTRAINT [FK_ProductionCasts_Members_MemberId] FOREIGN KEY ([MemberId]) REFERENCES [Members] ([Id]),
        CONSTRAINT [FK_ProductionCasts_Productions_ProductionId] FOREIGN KEY ([ProductionId]) REFERENCES [Productions] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823091712_AddProductionCastAndContactOverrides'
)
BEGIN
    CREATE INDEX [IX_ProductionCasts_DepMemberId] ON [ProductionCasts] ([DepMemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823091712_AddProductionCastAndContactOverrides'
)
BEGIN
    CREATE INDEX [IX_ProductionCasts_MemberId] ON [ProductionCasts] ([MemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823091712_AddProductionCastAndContactOverrides'
)
BEGIN
    CREATE INDEX [IX_ProductionCasts_ProductionId] ON [ProductionCasts] ([ProductionId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823091712_AddProductionCastAndContactOverrides'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260823091712_AddProductionCastAndContactOverrides', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    ALTER TABLE [ProductionEvents] DROP CONSTRAINT [FK_ProductionEvents_ProductionEventTypes_EventTypeId];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    EXEC sp_rename N'[ProductionEvents].[EventDate]', N'StartTime', 'COLUMN';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    DECLARE @var39 nvarchar(max);
    SELECT @var39 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ProductionEvents]') AND [c].[name] = N'Notes');
    IF @var39 IS NOT NULL EXEC(N'ALTER TABLE [ProductionEvents] DROP CONSTRAINT ' + @var39 + ';');
    EXEC(N'UPDATE [ProductionEvents] SET [Notes] = N'''' WHERE [Notes] IS NULL');
    ALTER TABLE [ProductionEvents] ALTER COLUMN [Notes] nvarchar(max) NOT NULL;
    ALTER TABLE [ProductionEvents] ADD DEFAULT N'' FOR [Notes];
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    DECLARE @var40 nvarchar(max);
    SELECT @var40 = QUOTENAME([d].[name])
    FROM [sys].[default_constraints] [d]
    INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
    WHERE ([d].[parent_object_id] = OBJECT_ID(N'[ProductionEvents]') AND [c].[name] = N'EventTypeId');
    IF @var40 IS NOT NULL EXEC(N'ALTER TABLE [ProductionEvents] DROP CONSTRAINT ' + @var40 + ';');
    ALTER TABLE [ProductionEvents] ALTER COLUMN [EventTypeId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    ALTER TABLE [ProductionEvents] ADD [EndTime] datetime2 NOT NULL DEFAULT '0001-01-01T00:00:00.0000000';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    ALTER TABLE [ProductionEvents] ADD [IsCastNotRequired] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    ALTER TABLE [ProductionEvents] ADD [IsTechnicalDate] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    ALTER TABLE [ProductionEvents] ADD [Location] nvarchar(max) NOT NULL DEFAULT N'';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    ALTER TABLE [ProductionEvents] ADD [SectionCovered] nvarchar(max) NOT NULL DEFAULT N'';
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    ALTER TABLE [ProductionEvents] ADD [ShowOnSchedule] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    CREATE TABLE [ProductionDeadlines] (
        [Id] int NOT NULL IDENTITY,
        [ProductionId] int NOT NULL,
        [Title] nvarchar(max) NOT NULL,
        [DueDate] datetime2 NOT NULL,
        [IsCompleted] bit NOT NULL,
        [ShowOnSchedule] bit NOT NULL,
        CONSTRAINT [PK_ProductionDeadlines] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ProductionDeadlines_Productions_ProductionId] FOREIGN KEY ([ProductionId]) REFERENCES [Productions] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    CREATE INDEX [IX_ProductionDeadlines_ProductionId] ON [ProductionDeadlines] ([ProductionId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    ALTER TABLE [ProductionEvents] ADD CONSTRAINT [FK_ProductionEvents_ProductionEventTypes_EventTypeId] FOREIGN KEY ([EventTypeId]) REFERENCES [ProductionEventTypes] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823095744_AddProductionEventsAndDeadlines'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260823095744_AddProductionEventsAndDeadlines', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823102050_AddArchivingAndEventTypeTargets'
)
BEGIN
    ALTER TABLE [Productions] ADD [IsArchived] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823102050_AddArchivingAndEventTypeTargets'
)
BEGIN
    ALTER TABLE [ProductionEventTypes] ADD [DefaultToRehearsalSchedule] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823102050_AddArchivingAndEventTypeTargets'
)
BEGIN
    ALTER TABLE [ProductionEventTypes] ADD [DefaultToTechSchedule] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823102050_AddArchivingAndEventTypeTargets'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260823102050_AddArchivingAndEventTypeTargets', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [Productions] ADD [CustomContentWarnings] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [Productions] ADD [WarnAdultLanguageLevel] int NOT NULL DEFAULT 0;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [Productions] ADD [WarnAudienceInteraction] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [Productions] ADD [WarnDistressingThemes] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [Productions] ADD [WarnFlashingLights] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [Productions] ADD [WarnGunshotsPyros] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [Productions] ADD [WarnLoudNoises] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [Productions] ADD [WarnSexualContent] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [Productions] ADD [WarnSmokeHaze] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [Productions] ADD [WarnStageSmoking] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [Productions] ADD [WarnViolenceGore] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [ProductionCrews] ADD [ScriptNumber] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [ProductionCasts] ADD [ScriptNumber] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    ALTER TABLE [Members] ADD [IsTemporaryPlaceholder] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823103947_AddContentWarningsAndUnavailability'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260823103947_AddContentWarningsAndUnavailability', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823104356_RegisterNewProductionDbSets'
)
BEGIN
    CREATE TABLE [ContentWarningTypes] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(max) NOT NULL,
        [IconClass] nvarchar(max) NOT NULL,
        [ShowOnFoHReport] bit NOT NULL,
        [IsEnabled] bit NOT NULL,
        [SortOrder] int NOT NULL,
        CONSTRAINT [PK_ContentWarningTypes] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823104356_RegisterNewProductionDbSets'
)
BEGIN
    CREATE TABLE [ProductionUnavailabilities] (
        [Id] int NOT NULL IDENTITY,
        [ProductionId] int NOT NULL,
        [MemberId] int NOT NULL,
        [StartDateTime] datetime2 NOT NULL,
        [EndDateTime] datetime2 NOT NULL,
        [Reason] nvarchar(max) NULL,
        CONSTRAINT [PK_ProductionUnavailabilities] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ProductionUnavailabilities_Members_MemberId] FOREIGN KEY ([MemberId]) REFERENCES [Members] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_ProductionUnavailabilities_Productions_ProductionId] FOREIGN KEY ([ProductionId]) REFERENCES [Productions] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823104356_RegisterNewProductionDbSets'
)
BEGIN
    CREATE TABLE [ProductionContentWarnings] (
        [Id] int NOT NULL IDENTITY,
        [ProductionId] int NOT NULL,
        [WarningTypeId] int NOT NULL,
        [IsActiveForShow] bit NOT NULL,
        [SpecificNotes] nvarchar(max) NULL,
        CONSTRAINT [PK_ProductionContentWarnings] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ProductionContentWarnings_ContentWarningTypes_WarningTypeId] FOREIGN KEY ([WarningTypeId]) REFERENCES [ContentWarningTypes] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_ProductionContentWarnings_Productions_ProductionId] FOREIGN KEY ([ProductionId]) REFERENCES [Productions] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823104356_RegisterNewProductionDbSets'
)
BEGIN
    CREATE INDEX [IX_ProductionContentWarnings_ProductionId] ON [ProductionContentWarnings] ([ProductionId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823104356_RegisterNewProductionDbSets'
)
BEGIN
    CREATE INDEX [IX_ProductionContentWarnings_WarningTypeId] ON [ProductionContentWarnings] ([WarningTypeId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823104356_RegisterNewProductionDbSets'
)
BEGIN
    CREATE INDEX [IX_ProductionUnavailabilities_MemberId] ON [ProductionUnavailabilities] ([MemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823104356_RegisterNewProductionDbSets'
)
BEGIN
    CREATE INDEX [IX_ProductionUnavailabilities_ProductionId] ON [ProductionUnavailabilities] ([ProductionId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823104356_RegisterNewProductionDbSets'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260823104356_RegisterNewProductionDbSets', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823110238_SyncProductionEventTypeAndEvent'
)
BEGIN
    ALTER TABLE [ProductionEvents] ADD [CharactersRequired] nvarchar(max) NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823110238_SyncProductionEventTypeAndEvent'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260823110238_SyncProductionEventTypeAndEvent', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823111600_AddPerformanceIntervalAndEndTime'
)
BEGIN
    ALTER TABLE [Performances] ADD [EndTime] datetime2 NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823111600_AddPerformanceIntervalAndEndTime'
)
BEGIN
    ALTER TABLE [Performances] ADD [IntervalTime] datetime2 NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260823111600_AddPerformanceIntervalAndEndTime'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260823111600_AddPerformanceIntervalAndEndTime', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165501_LinkKeysToMembers'
)
BEGIN
    ALTER TABLE [Keys] ADD [IssuedToMemberId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165501_LinkKeysToMembers'
)
BEGIN
    ALTER TABLE [CheckoutTransactions] ADD [IssuedToMemberId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165501_LinkKeysToMembers'
)
BEGIN
    ALTER TABLE [Bunches] ADD [IssuedToMemberId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165501_LinkKeysToMembers'
)
BEGIN
    CREATE INDEX [IX_Keys_IssuedToMemberId] ON [Keys] ([IssuedToMemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165501_LinkKeysToMembers'
)
BEGIN
    CREATE INDEX [IX_CheckoutTransactions_IssuedToMemberId] ON [CheckoutTransactions] ([IssuedToMemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165501_LinkKeysToMembers'
)
BEGIN
    CREATE INDEX [IX_Bunches_IssuedToMemberId] ON [Bunches] ([IssuedToMemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165501_LinkKeysToMembers'
)
BEGIN
    ALTER TABLE [Bunches] ADD CONSTRAINT [FK_Bunches_Members_IssuedToMemberId] FOREIGN KEY ([IssuedToMemberId]) REFERENCES [Members] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165501_LinkKeysToMembers'
)
BEGIN
    ALTER TABLE [CheckoutTransactions] ADD CONSTRAINT [FK_CheckoutTransactions_Members_IssuedToMemberId] FOREIGN KEY ([IssuedToMemberId]) REFERENCES [Members] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165501_LinkKeysToMembers'
)
BEGIN
    ALTER TABLE [Keys] ADD CONSTRAINT [FK_Keys_Members_IssuedToMemberId] FOREIGN KEY ([IssuedToMemberId]) REFERENCES [Members] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165501_LinkKeysToMembers'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260824165501_LinkKeysToMembers', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165941_AddKeyMemberIssueLinks'
)
BEGIN
    ALTER TABLE [CheckoutTransactions] ADD [AuthorizedByMemberId] int NULL;
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165941_AddKeyMemberIssueLinks'
)
BEGIN
    CREATE INDEX [IX_CheckoutTransactions_AuthorizedByMemberId] ON [CheckoutTransactions] ([AuthorizedByMemberId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165941_AddKeyMemberIssueLinks'
)
BEGIN
    ALTER TABLE [CheckoutTransactions] ADD CONSTRAINT [FK_CheckoutTransactions_Members_AuthorizedByMemberId] FOREIGN KEY ([AuthorizedByMemberId]) REFERENCES [Members] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824165941_AddKeyMemberIssueLinks'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260824165941_AddKeyMemberIssueLinks', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824173935_LinkedKeyBunch'
)
BEGIN
    CREATE INDEX [IX_ProductionRoles_LinkedKeyBunchId] ON [ProductionRoles] ([LinkedKeyBunchId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824173935_LinkedKeyBunch'
)
BEGIN
    ALTER TABLE [ProductionRoles] ADD CONSTRAINT [FK_ProductionRoles_Bunches_LinkedKeyBunchId] FOREIGN KEY ([LinkedKeyBunchId]) REFERENCES [Bunches] ([Id]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824173935_LinkedKeyBunch'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260824173935_LinkedKeyBunch', N'10.0.5');
END;

COMMIT;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824174715_AddKeyResolutionFlag'
)
BEGIN
    ALTER TABLE [ProductionCrews] ADD [KeyRequirementResolved] bit NOT NULL DEFAULT CAST(0 AS bit);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20260824174715_AddKeyResolutionFlag'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20260824174715_AddKeyResolutionFlag', N'10.0.5');
END;

COMMIT;
GO

