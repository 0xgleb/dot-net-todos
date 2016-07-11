CREATE TABLE [dbo].[TaskTable] (
    [Id]       INT          IDENTITY (1, 1) NOT NULL,
    [Task]     VARCHAR (50) NOT NULL,
    [IsActive] BIT          NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

