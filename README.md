CREATE TABLE [dbo].[App_WorkOrder_Exemption_Remarks] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]     DATETIME         NULL,
    [CreatedBy]     VARCHAR(50)      NULL,
    [Remarks]       VARCHAR(MAX)     NULL,
    [Attachment]    VARCHAR(MAX)     NULL,
    [MASTER_ID]     UNIQUEIDENTIFIER NULL,
    
    CONSTRAINT [PK_App_WorkOrder_Exemption_Remarks] 
        PRIMARY KEY CLUSTERED ([ID] ASC),

    CONSTRAINT [FK_WorkOrder_Exemption_Remarks_Master]
        FOREIGN KEY ([MASTER_ID]) 
        REFERENCES [dbo].[App_WorkOrder_Exemption]([ID])
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
