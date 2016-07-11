CREATE TABLE [dbo].[TaskTables] (
    [Id]       INT          NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    [Task]     VARCHAR (50) NOT NULL,
    [IsActive] BIT          NOT NULL,
);

