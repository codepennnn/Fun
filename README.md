CREATE TABLE [dbo].[App_WorkOrder_Exemption_Remarks] (
    [ID]               UNIQUEIDENTIFIER NOT NULL,
    [CreatedOn]        DATETIME         NULL,
    [CreatedBy]        VARCHAR (50)     NULL,
    [Remarks]          VARCHAR (MAX)    NULL,
    [Attachment]       VARCHAR (MAX)    NULL,
	[MASTER_ID]      UNIQUEIDENTIFIER NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC)
	CONSTRAINT [PK_App_WorkOrder_Exemption_Remarks] PRIMARY KEY CLUSTERED ([ID] ASC)
);
