/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


create or alter procedure bronze.load_bronze as 
Begin
	declare @start_time datetime , @end_time datetime, @batch_start_time datetime, @batch_end_time datetime
	
	set @batch_start_time = GETDATE();
	print '---------------------------------------------------------'
	print 'Loading Bronze Layer '
	print '---------------------------------------------------------'

	print '---------------------------------------------------------'
	print 'Loading CRM Tables '
	print '---------------------------------------------------------'

	set @start_time = GETDATE();
	print 'Truncate table: bronze.crm_cust_info'
	print '---------------------------------------------------------'
	truncate table bronze.crm_cust_info

	print 'Inserting data into table: bronze.crm_cust_info'
	print '---------------------------------------------------------'
	bulk insert bronze.crm_cust_info 
	from 'D:\SQL - DW Baraa\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with (
		 firstrow = 2,
		 fieldterminator = ',',
		 tablock
		 );
	set @end_time = GETDATE();
	print '>> Load Duration : ' + cast (datediff (second, @start_time, @end_time) as nvarchar ) + ' seconds';
	PRINT '>> -------------';


	set @start_time = GETDATE();
	print 'Truncate table: bronze.crm_prd_info'
	print '---------------------------------------------------------'
	truncate table bronze.crm_prd_info

	print 'Inserting data into table: bronze.crm_prd_info '
	print '---------------------------------------------------------'
	bulk insert bronze.crm_prd_info 
	from 'D:\SQL - DW Baraa\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with (
		 firstrow = 2,
		 fieldterminator = ',',
		 tablock
		 );
	set @end_time = GETDATE();
	print '>> Load Duration : ' + cast (datediff (second, @start_time, @end_time) as nvarchar ) + ' seconds';
	PRINT '>> -------------';

	SET @start_time = GETDATE();
	print 'Truncate table: bronze.crm_sales_details'
	print '---------------------------------------------------------'
	truncate table bronze.crm_sales_details

	print 'Inserting data into table: bronze.crm_sales_details'
	print '---------------------------------------------------------'
	bulk insert bronze.crm_sales_details
	from 'D:\SQL - DW Baraa\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	with (
		 firstrow = 2,
		 fieldterminator = ',',
		 tablock
		 )
	SET @end_time = GETDATE();
	print '>> Load Duration : ' + cast (datediff (second, @start_time, @end_time) as nvarchar ) + ' seconds';
	PRINT '>> -------------';


	print '---------------------------------------------------------'
	print 'Loading ERP Tables'
	print '---------------------------------------------------------'

	SET @start_time = GETDATE();
	print 'Truncate table: bronze.erp_CUST_AZ12'
	print '---------------------------------------------------------'
	truncate table bronze.erp_CUST_AZ12

	print 'Inserting data into table: bronze.erp_CUST_AZ12'
	print '---------------------------------------------------------'
	bulk insert bronze.erp_CUST_AZ12
	from 'D:\SQL - DW Baraa\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	with (
		 firstrow = 2,
		 fieldterminator = ',',
		 tablock
		 )
	SET @end_time = GETDATE();
	print '>> Load Duration : ' + cast (datediff (second, @start_time, @end_time) as nvarchar ) + ' seconds';
	PRINT '>> -------------';


	SET @start_time = GETDATE();
	print 'Truncate table: bronze.erp_LOC_A101'
	print '---------------------------------------------------------'
	truncate table bronze.erp_LOC_A101

	print 'Inserting data into table: bronze.erp_LOC_A101'
	print '---------------------------------------------------------'
	bulk insert bronze.erp_LOC_A101
	from 'D:\SQL - DW Baraa\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	with (
		 firstrow = 2,
		 fieldterminator = ',',
		 tablock
		 )
	SET @end_time = GETDATE();
	print '>> Load Duration : ' + cast (datediff (second, @start_time, @end_time) as nvarchar ) + ' seconds';
	PRINT '>> -------------';


	SET @start_time = GETDATE();
	print 'Truncate table: bronze.erp_PX_CAT_G1V2'
	print '---------------------------------------------------------'
	truncate table bronze.erp_PX_CAT_G1V2

	print 'Inserting data into table: bronze.erp_PX_CAT_G1V2'
	print '---------------------------------------------------------'
	bulk insert bronze.erp_PX_CAT_G1V2
	from 'D:\SQL - DW Baraa\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	with (
		 firstrow = 2,
		 fieldterminator = ',',
		 tablock
		 ) 
	SET @end_time = GETDATE();
	print '>> Load Duration : ' + cast (datediff (second, @start_time, @end_time) as nvarchar ) + ' seconds';
	PRINT '>> -------------';
	
	set @batch_end_time = GETDATE();
	PRINT '=========================================='
	PRINT 'Loading Bronze Layer is Completed';
    PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
	PRINT '=========================================='

end 
