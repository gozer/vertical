CREATE TABLE IF NOT EXISTS public.locations
(
    location_id int NOT NULL,
    continent_code varchar(2),
    continent_name varchar(13),
    country_code varchar(2),
    country_name varchar(50),
    region_code varchar(2),
    region_name varchar(50),
    city_name varchar(50),
    latitude float,
    longitude float,
    geohash varchar(6),
    insert_date date,
    CONSTRAINT locations_pk PRIMARY KEY (location_id) DISABLED
);

CREATE TABLE IF NOT EXISTS public.product_channels
(
    product_channel_id int NOT NULL,
    product_channel varchar(100),
    partner varchar(50),
    CONSTRAINT product_channels_1 PRIMARY KEY (product_channel_id) DISABLED
);

CREATE TABLE IF NOT EXISTS public.products
(
    product_id int NOT NULL,
    product_guid varchar(36) NOT NULL,
    product_name varchar(20) NOT NULL,
    product_version varchar(30) NOT NULL,
    product_version_major int,
    product_version_minor int,
    product_version_minor_suffix varchar(15),
    product_version_sub_a int,
    product_version_sub_a_suffix varchar(15),
    product_version_sub_b int,
    product_version_sub_b_suffix varchar(15),
    formatted_version_major varchar(7),
    CONSTRAINT products_pk PRIMARY KEY (product_id) DISABLED
);

CREATE TABLE IF NOT EXISTS public.ffos_dimensional_by_date
(
    _year_quarter varchar(7),
    date varchar(10),
    product varchar(20),
    v_prod_major varchar(7),
    prod_os varchar(50),
    v_prod_os varchar(50),
    continent_code varchar(2),
    cntry_code varchar(2),
    isp_name varchar(100),
    device_type varchar(100),
    tot_request_on_date int
);

CREATE TABLE IF NOT EXISTS public.f_bugs_snapshot_v2
(
    id  IDENTITY ,
    es_id varchar(255),
    bug_id varchar(255),
    bug_severity varchar(255),
    bug_status varchar(255),
    bug_version_num varchar(255),
    assigned_to varchar(255),
    component varchar(255),
    created_by varchar(255),
    created_ts timestamp,
    modified_by varchar(255),
    modified_ts timestamp,
    op_sys varchar(255),
    priority varchar(255),
    product varchar(255),
    qa_contact varchar(255),
    reported_by varchar(255),
    reporter varchar(255),
    version varchar(255),
    expires_on varchar(255),
    cf_due_date varchar(255),
    target_milestone varchar(255),
    short_desc varchar(1024),
    bug_status_resolution varchar(1024),
    keywords varchar(1024),
    snapshot_date date
);


CREATE TABLE IF NOT EXISTS public.f_bugs_status_resolution
(
    bug_id varchar(255),
    bug_severity varchar(55),
    short_desc varchar(1024),
    bug_status varchar(255),
    bug_status_previous varchar(255),
    status_update varchar(255),
    status_change_update date,
    curr_snapshot_date date
);


CREATE TABLE IF NOT EXISTS public.mozilla_staff
(
    employee_id varchar(255),
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(512),
    supervisory_organization varchar(255),
    cost_center varchar(255),
    functional_group varchar(255),
    manager_id varchar(255),
    manager_lastname varchar(255),
    manager_firstname varchar(255),
    is_manager varchar(2),
    hire_date date,
    location varchar(255),
    snapshot_date date
);

CREATE TABLE public.mozilla_staff_plus
(
    employee_id varchar(255),
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(512),
    supervisory_organization varchar(255),
    cost_center varchar(255),
    functional_group varchar(255),
    manager_id varchar(255),
    manager_lastname varchar(255),
    manager_firstname varchar(255),
    manager_email varchar(512),
    is_manager varchar(2),
    hire_date date,
    location varchar(255),
    home_city varchar(255),
    home_country varchar(255),
    home_postal varchar(255),
    desk_number varchar(255),
    snapshot_date date
);

CREATE TABLE IF NOT EXISTS public.firefox_download_counts
(
    date varchar(25),
    country_code varchar(25),
    count int,
    ua_family varchar(128),
    ua_major varchar(128),
    os_family varchar(128),
    product_name varchar(1024),
    product_type varchar(1024),
    download_type varchar(128),
    other varchar(1024),
    locale varchar(50)
);


CREATE TABLE IF NOT EXISTS public.adi_firefox_by_date_version_country_locale_channel
(
    ping_date date NOT NULL,
    version varchar(20) NOT NULL DEFAULT '',
    country varchar(80) NOT NULL DEFAULT '',
    locale varchar(50) NOT NULL DEFAULT '',
    release_channel varchar(100) NOT NULL DEFAULT '',
    ADI int,
    CONSTRAINT C_PRIMARY PRIMARY KEY (ping_date, country, locale, version, release_channel) DISABLED
);

CREATE TABLE IF NOT EXISTS public.a_downloads_locale_location_channel
(
    dates_Year int,
    dates_Month int,
    dates_Day_of_month int,
    dates_Date varchar(10),
    download_products_Name varchar(20),
    download_products_Major varchar(7),
    download_products_Version varchar(30),
    request_types_Type varchar(10),
    download_types_Type varchar(10),
    request_result_Result varchar(10),
    locales_Code varchar(15),
    locations_Continent_name varchar(13),
    locations_Country_name varchar(50),
    download_products_rebuild_Name varchar(20),
    download_products_rebuild_Channel varchar(20),
    download_requests_by_day_Total_Requests int,
    download_requests_by_day_fact_count int
);


CREATE TABLE IF NOT EXISTS public.releases
(
    is_released boolean,
    version_int int,
    version varchar(7),
    channel varchar(10),
    merge_date date,
    release_date date,
    product varchar(10)
);


CREATE TABLE IF NOT EXISTS public.adi_by_region
(
    yr char(4) NOT NULL,
    mnth char(2) NOT NULL,
    region varchar(50) NOT NULL,
    country_code char(2) NOT NULL,
    domain varchar(50) NOT NULL,
    tot_requests int,
    product varchar(20) NOT NULL,
    CONSTRAINT C_PRIMARY PRIMARY KEY (yr, mnth, region, country_code, domain, product) DISABLED
);

CREATE TABLE IF NOT EXISTS public.nagios_log_data
(
    event_occurred_at timestamp,
    incident_type varchar(64),
    host varchar(256),
    service varchar(256),
    status varchar(32),
    notify_by varchar(256),
    description varchar(2048),
    filename varchar(255) DEFAULT ''
);


CREATE TABLE IF NOT EXISTS public.snippet_count_20151104
(
    date date NOT NULL,
    ua_family varchar(64),
    ua_major int,
    os_family varchar(64),
    country_code char(2),
    snippet_id varchar(64),
    impression_count int,
    locale varchar(100),
    metric varchar(100),
    user_country char(2),
    campaign varchar(255)
)
PARTITION BY (date_part('month', snippet_count_20151104.date));


CREATE TABLE IF NOT EXISTS public.snippet_count_fennec_20151104
(
    utc_time varchar(255),
    local_time varchar(255),
    country_code varchar(255),
    country_name varchar(255),
    latitude varchar(255),
    longitude varchar(255),
    city varchar(255),
    domain_name varchar(255),
    org_name varchar(255),
    isp_name varchar(255),
    request_type varchar(255),
    request_url varchar(255),
    http_status_code varchar(255),
    response_size_in_bytes varchar(255),
    referring_url varchar(255),
    ua_family varchar(255),
    ua_major varchar(255),
    ua_minor varchar(255),
    os_family varchar(255),
    os_major varchar(255),
    os_minor varchar(255),
    device_family varchar(255),
    custom_field_1 varchar(255),
    custom_field_2 varchar(255),
    custom_field_3 varchar(255),
    filename varchar(255),
    snippet_id numeric(20,0),
    snippet_impression_date varchar(255)
);


CREATE TABLE IF NOT EXISTS public.vertica_backups
(
    backupDate date,
    sizeBytes int,
    node varchar(50),
    status varchar(15),
    snapshotDate date
);


CREATE TABLE IF NOT EXISTS public.adi_dimensional_by_date_test
(
    _year_quarter varchar(7),
    bl_date date,
    product varchar(20),
    v_prod_major varchar(7),
    prod_os varchar(50),
    v_prod_os varchar(50),
    channel varchar(100),
    locale varchar(50),
    continent_code varchar(2),
    cntry_code varchar(2),
    tot_requests_on_date int,
    distro_name varchar(100),
    distro_version varchar(100),
    buildid varchar(20)
);


CREATE TABLE IF NOT EXISTS public.v4_submissionwise_v5
(
    submission_date date,
    search_provider varchar(255),
    search_count int,
    country varchar(255),
    locale varchar(255),
    distribution_id varchar(255),
    default_provider varchar(255),
    profiles_matching int,
    profile_share float,
    intermediate_source varchar(255)
);


CREATE TABLE IF NOT EXISTS public.ut_monthly_rollups_old
(
    month char(7),
    search_provider varchar(255),
    search_count int,
    country varchar(255),
    locale varchar(255),
    distribution_id varchar(255),
    default_provider varchar(255),
    profiles_matching int,
    processed date
);


CREATE TABLE IF NOT EXISTS public.ut_monthly_rollups
(
    month date,
    search_provider varchar(255),
    search_count int,
    country varchar(255),
    locale varchar(255),
    distribution_id varchar(255),
    default_provider varchar(255),
    profiles_matching int,
    processed date
);


CREATE TABLE IF NOT EXISTS public.v4_submissionwise_v5_test
(
    submission_date date,
    search_provider varchar(255),
    search_count int,
    country varchar(255),
    locale varchar(255),
    distribution_id varchar(255),
    default_provider varchar(255),
    profiles_matching int,
    profile_share float,
    intermediate_source varchar(255)
);


CREATE TABLE IF NOT EXISTS public.search_cohort
(
    channel varchar(50),
    geo char(2),
    is_funnelcake boolean,
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active boolean,
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float
);


CREATE TABLE IF NOT EXISTS public.fx_desktop_er
(
    activity_date date,
    mau int,
    dau int,
    smooth_dau float,
    er float
);


CREATE TABLE IF NOT EXISTS public.fx_desktop_er_by_top_countries
(
    country char(2),
    activity_date date,
    mau int,
    dau int,
    smooth_dau float,
    er float
);


CREATE TABLE IF NOT EXISTS public.brain_juicer
(
    month_year date,
    country varchar(80),
    sample_size int,
    brand varchar(50),
    uba_as_io float,
    uba_as_browser float,
    mozilla_bpi float,
    non_profit_cc float,
    opinionated_cc float,
    innovative_cc float,
    inclusive_cc float,
    firefox_bpi float,
    independent float,
    trustworty float,
    non_profit float,
    empowering float,
    aware_health_of_internet float,
    aware_online_priv_sec float,
    aware_open_innovation float,
    aware_decentralization float,
    aware_web_literacy float,
    aware_digital_inclusion float,
    care_online_priv_sec float,
    care_open_innovation float,
    care_decentralization float,
    care_web_literacy float,
    care_inclusion float
);


CREATE TABLE IF NOT EXISTS public.statcounter
(
    st_date date,
    browser varchar(100),
    stat float,
    region varchar(75),
    device varchar(50)
);


CREATE TABLE IF NOT EXISTS public.v4_monthly
(
    geo varchar(10),
    channel varchar(10),
    os varchar(35),
    v4_date date,
    actives int,
    hours float,
    inactives int,
    new_records int,
    five_of_seven int,
    total_records int,
    crashes int,
    v4_default int,
    google int,
    bing int,
    yahoo int,
    other int
);


CREATE TABLE IF NOT EXISTS public.engagement_ratio
(
    day date,
    dau int,
    mau int,
    generated_on date
);


CREATE TABLE IF NOT EXISTS public.blocklistDecomposition
(
    bd_date date,
    dayNum int,
    dayOfWeek varchar(25),
    yearFreq float,
    adi float,
    trend float,
    seasonal float,
    weekly float,
    outlier float,
    noise float
);


CREATE TABLE IF NOT EXISTS public.fx_adjust_mobile
(
    fx_date date,
    maus float,
    daus float
);


CREATE TABLE IF NOT EXISTS public.search_cohort_churn_test
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    is_active varchar(3),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float,
    week_start date
);


CREATE TABLE IF NOT EXISTS public.search_cohort_churn_tmp
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    is_active varchar(3),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float,
    week_start date
);


CREATE TABLE IF NOT EXISTS public.mysql_status_counters
(
    mysql_host_id int,
    status_date date,
    Aborted_clients int,
    Aborted_connects int,
    Binlog_cache_disk_use int,
    Binlog_cache_use int,
    Binlog_stmt_cache_use int,
    Bytes_received int,
    Bytes_sent int,
    Com_admin_commands int,
    Com_begin int,
    Com_change_db int,
    Com_commit int,
    Com_create_db int,
    Com_create_table int,
    Com_delete int,
    Com_insert int,
    Com_insert_select int,
    Com_replace int,
    Com_replace_select int,
    Com_select int,
    Com_set_option int,
    Com_show_create_table int,
    Com_show_databases int,
    Com_show_engine_status int,
    Com_show_fields int,
    Com_show_grants int,
    Com_show_processlist int,
    Com_show_slave_status int,
    Com_show_status int,
    Com_show_tables int,
    Com_show_variables int,
    Com_truncate int,
    Com_update int,
    Connections int,
    Created_tmp_disk_tables int,
    Created_tmp_tables int,
    Handler_commit int,
    Handler_delete int,
    Handler_external_lock int,
    Handler_prepare int,
    Handler_read_first int,
    Handler_read_key int,
    Handler_read_next int,
    Handler_read_rnd int,
    Handler_read_rnd_next int,
    Handler_update int,
    Handler_write int,
    Innodb_buffer_pool_bytes_data int,
    Innodb_buffer_pool_pages_flushed int,
    Innodb_buffer_pool_read_ahead int,
    Innodb_buffer_pool_read_ahead_evicted int,
    Innodb_buffer_pool_read_requests int,
    Innodb_buffer_pool_reads int,
    Innodb_buffer_pool_write_requests int,
    Innodb_data_fsyncs int,
    Innodb_data_read int,
    Innodb_data_reads int,
    Innodb_data_writes int,
    Innodb_data_written int,
    Innodb_dblwr_pages_written int,
    Innodb_dblwr_writes int,
    Innodb_log_write_requests int,
    Innodb_log_writes int,
    Innodb_os_log_fsyncs int,
    Innodb_os_log_written int,
    Innodb_pages_created int,
    Innodb_pages_read int,
    Innodb_pages_written int,
    Innodb_rows_deleted int,
    Innodb_rows_inserted int,
    Innodb_rows_read int,
    Innodb_rows_updated int,
    Innodb_num_open_files int,
    Innodb_available_undo_logs int,
    Key_read_requests int,
    Key_reads int,
    Key_write_requests int,
    Key_writes int,
    Open_table_definitions int,
    Opened_files int,
    Opened_table_definitions int,
    Opened_tables int,
    Queries int,
    Questions int,
    Select_range int,
    Select_scan int,
    Slow_queries int,
    Sort_rows int,
    Sort_scan int,
    Table_locks_immediate int,
    Table_open_cache_hits int,
    Table_open_cache_misses int,
    Uptime int
);


CREATE TABLE IF NOT EXISTS public.mysql_host
(
    id  IDENTITY ,
    name varchar(250),
    CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED
);

CREATE TABLE IF NOT EXISTS public.mysql_system
(
    mysql_host_id int,
    system_type varchar(250),
    system_os varchar(250),
    system_os_release varchar(250),
    is_virtual boolean,
    virtualized varchar(250),
    processor varchar(250),
    processor_speed varchar(250),
    processor_model varchar(250),
    memory varchar(250),
    memory_free varchar(250),
    disk_size int
);


CREATE TABLE IF NOT EXISTS public.mysql_host_metrics
(
    mysql_host_id int,
    metrics_date date,
    version varchar(250),
    full_text_index boolean,
    geospatial boolean,
    ssl boolean,
    binlog_format varchar(250),
    default_storage_engine varchar(250),
    sql_mode varchar(250)
);


CREATE TABLE IF NOT EXISTS public.mysql_database
(
    mysql_host_id int,
    database_date date,
    name varchar(250),
    innodb_tables int,
    myisam_tables int,
    csv_tables int
);


CREATE TABLE IF NOT EXISTS public.adjust_ios_monthly
(
    adj_date date,
    daus float,
    waus float,
    maus float
);


CREATE TABLE IF NOT EXISTS public.adjust_android_monthly
(
    adj_date date,
    daus float,
    waus float,
    maus float
);


CREATE TABLE IF NOT EXISTS public.adjust_focus_monthly
(
    adj_date date,
    daus float,
    waus float,
    maus float,
    installs int
);


CREATE TABLE IF NOT EXISTS public.adjust_klar_monthly
(
    adj_date date,
    daus float,
    waus float,
    maus float,
    installs int
);


CREATE TABLE IF NOT EXISTS public.sfmc
(
    sf_date timestamp,
    email_program varchar(50),
    first_run_source char(5),
    country varchar(50),
    language char(2),
    metric varchar(50),
    value int
);


CREATE TABLE IF NOT EXISTS public.sfmc_emails_sent_html
(
    id int NOT NULL,
    value int
);


CREATE TABLE IF NOT EXISTS public.sfmc_emails_sent
(
    id int NOT NULL,
    value int
);


CREATE TABLE IF NOT EXISTS public.sfmc_clicks
(
    id int NOT NULL,
    value int
);


CREATE TABLE IF NOT EXISTS public.sfmc_bounces
(
    id int NOT NULL,
    value int
);


CREATE TABLE IF NOT EXISTS public.sfmc_base
(
    id  IDENTITY ,
    sf_date timestamp,
    email_program varchar(50),
    first_run_source char(5),
    country varchar(50),
    language char(2),
    metric varchar(50),
    value int,
    CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED
);

CREATE TABLE IF NOT EXISTS public.sfmc_opens
(
    id int NOT NULL,
    value int
);


CREATE TABLE IF NOT EXISTS public.cohort_churn
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active varchar(3),
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float
);


CREATE TABLE IF NOT EXISTS public.raw_scvp_okr
(
    id  IDENTITY ,
    update_date date DEFAULT ('now()')::date,
    accountable_scvp varchar(250),
    okr varchar(250),
    status long varchar(1000),
    score varchar(10),
    metric_start varchar(10),
    current_metric varchar(10),
    target_metric varchar(250),
    cur_month_status varchar(250),
    next_milestone varchar(250),
    status_owner varchar(250),
    data_source varchar(250),
    data_owner varchar(250),
    CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED
);

CREATE TABLE IF NOT EXISTS public.copy_cohort_churn
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active varchar(3),
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float
);


CREATE TABLE IF NOT EXISTS public.fx_market_share
(
    fx_date date,
    fx_mkt_share float
);


CREATE TABLE IF NOT EXISTS public.sfmc_tmp
(
    sf_date timestamp,
    email_program varchar(50),
    first_run_source char(5),
    country varchar(50),
    language char(2),
    metric varchar(50),
    value int
);


CREATE TABLE IF NOT EXISTS public.fx_product_tmp
(
    geo varchar(10),
    channel varchar(10),
    os varchar(35),
    v4_date date,
    actives int,
    hours float,
    inactives int,
    new_records int,
    five_of_seven int,
    total_records int,
    crashes int,
    v4_default int,
    google int,
    bing int,
    yahoo int,
    other int,
    dau int,
    adi int
);


CREATE TABLE IF NOT EXISTS public.org_okr_stage
(
    type varchar(50),
    status varchar(10),
    okr varchar(250),
    responsible varchar(250),
    monthly_status varchar(250),
    next_major_milestone varchar(250),
    metric_at_start varchar(10),
    current_metric varchar(10),
    target_metric varchar(10),
    score varchar(10),
    data_source varchar(250),
    data_owner varchar(250),
    mozilla_okr varchar(50),
    org_level_okr varchar(250),
    modified_on varchar(250),
    modified_by varchar(250)
);


CREATE TABLE IF NOT EXISTS public.org_okr_group
(
    id  IDENTITY ,
    ts timestamp DEFAULT ('now()')::timestamptz,
    name varchar(255),
    CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED
);

CREATE TABLE IF NOT EXISTS public.org_okr_type
(
    type_id  IDENTITY ,
    group_id int,
    duration varchar(255),
    okr_type varchar(250),
    status varchar(50),
    okr_name varchar(255),
    responsible varchar(255),
    monthly_status varchar(255),
    next_major_milestone varchar(250),
    score varchar(250),
    metric_at_start varchar(10),
    current_metric varchar(10),
    target_metric varchar(10),
    data_source varchar(250),
    data_owner varchar(250),
    modified_on varchar(250),
    modified_by varchar(250),
    CONSTRAINT C_PRIMARY PRIMARY KEY (type_id) DISABLED
);

CREATE TABLE IF NOT EXISTS public.org_okr_keyresult
(
    type_id int,
    duration varchar(255),
    okr_type varchar(250),
    status varchar(50),
    kr_name varchar(255),
    responsible varchar(255),
    monthly_status varchar(255),
    next_major_milestone varchar(250),
    score varchar(250),
    metric_at_start varchar(10),
    current_metric varchar(10),
    target_metric varchar(10),
    data_source varchar(250),
    data_owner varchar(250),
    modified_on varchar(250),
    modified_by varchar(250)
);


CREATE TABLE IF NOT EXISTS public.search_cohort_churn
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active varchar(3),
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float,
    week_start date
);


CREATE TABLE IF NOT EXISTS public.net_neutrality_petition
(
    ts timestamp,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    locale char(5)
);


CREATE TABLE IF NOT EXISTS public.open_data_day
(
    ts timestamp,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    locale char(5)
);


CREATE TABLE IF NOT EXISTS public.sf_donation_count
(
    opp_name varchar(20),
    opp_type varchar(50),
    lead_source varchar(50),
    amount float,
    close_date date,
    next_step varchar(50),
    stage varchar(20),
    probability int,
    fiscal_period char(7),
    age float,
    created_date date,
    opp_owner varchar(50),
    owner_role varchar(50),
    account_name varchar(50)
);


CREATE TABLE IF NOT EXISTS public.statcounter_monthly
(
    st_date date,
    stat float
);


CREATE TABLE IF NOT EXISTS public.tmp_search_cohort_churn
(
    channel varchar(50),
    geo varchar(3),
    is_funnelcake varchar(3),
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    current_week int,
    is_active varchar(3),
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250),
    distribution_id varchar(250),
    default_search_engine varchar(250),
    locale varchar(10),
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float,
    week_start date
);


CREATE TABLE IF NOT EXISTS public.fhr_rollups_monthly_base
(
    vendor varchar(50),
    name varchar(50),
    channel varchar(50),
    os varchar(50),
    osdetail varchar(50),
    distribution varchar(50),
    locale varchar(50),
    geo varchar(50),
    version varchar(50),
    isstdprofile varchar(50),
    stdchannel varchar(50),
    stdos varchar(50),
    distribtype varchar(50),
    snapshot varchar(50),
    granularity varchar(50),
    timeStart varchar(50),
    timeEnd varchar(50),
    tTotalProfiles int,
    tExistingProfiles int,
    tNewProfiles int,
    tActiveProfiles int,
    tInActiveProfiles int,
    tActiveDays int,
    tTotalSeconds int,
    tActiveSeconds int,
    tNumSessions int,
    tCrashes int,
    tTotalSearch int,
    tGoogleSearch int,
    tYahooSearch int,
    tBingSearch int,
    tOfficialSearch int,
    tIsDefault int,
    tIsActiveProfileDefault int,
    t5outOf7 int,
    tChurned int,
    tHasUP int
);


CREATE TABLE IF NOT EXISTS public.fhr_rollups_monthly_base_2015
(
    vendor varchar(50),
    name varchar(50),
    channel varchar(50),
    os varchar(50),
    osdetail varchar(50),
    distribution varchar(50),
    locale varchar(50),
    geo varchar(50),
    version varchar(50),
    isstdprofile varchar(50),
    stdchannel varchar(50),
    stdos varchar(50),
    distribtype varchar(50),
    snapshot varchar(50),
    granularity varchar(50),
    timeStart varchar(50),
    timeEnd varchar(50),
    tTotalProfiles int,
    tExistingProfiles int,
    tNewProfiles int,
    tActiveProfiles int,
    tInActiveProfiles int,
    tActiveDays int,
    tTotalSeconds int,
    tActiveSeconds int,
    tNumSessions int,
    tCrashes int,
    tTotalSearch int,
    tGoogleSearch int,
    tYahooSearch int,
    tBingSearch int,
    tOfficialSearch int,
    tIsDefault int,
    tIsActiveProfileDefault int,
    t5outOf7 int,
    tChurned int,
    tHasUP int
);


CREATE TABLE IF NOT EXISTS public.churn_cohort
(
    channel varchar(50),
    country char(2),
    is_funnelcake boolean,
    acquisition_period date,
    start_version varchar(10),
    sync_usage varchar(10),
    current_version varchar(10),
    week_since_acquisition int,
    is_active boolean,
    n_profiles int,
    usage_hours float,
    sum_squared_usage_hours float
);


CREATE TABLE IF NOT EXISTS public.fx_attribution
(
    profiles_count int,
    source varchar(250),
    medium varchar(250),
    campaign varchar(250),
    content varchar(250)
);


CREATE TABLE IF NOT EXISTS public.copy_adi_dimensional_by_date_s3
(
    _year_quarter varchar(7),
    bl_date date,
    product varchar(20),
    v_prod_major varchar(7),
    prod_os varchar(50),
    v_prod_os varchar(50),
    channel varchar(100),
    locale varchar(50),
    continent_code varchar(2),
    cntry_code varchar(2),
    tot_requests_on_date int,
    distro_name varchar(100),
    distro_version varchar(100),
    buildid varchar(20) DEFAULT ''
);


CREATE TABLE IF NOT EXISTS public.snippet_count
(
    date date NOT NULL,
    ua_family varchar(64),
    ua_major int,
    os_family varchar(64),
    country_code char(2),
    snippet_id varchar(64),
    impression_count int,
    locale varchar(100),
    metric varchar(100) DEFAULT '',
    user_country char(2),
    campaign varchar(255)
)
PARTITION BY (date_part('month', snippet_count.date));


CREATE TABLE IF NOT EXISTS public.ut_desktop_daily_active_users_extended
(
    day date,
    mau int,
    dau int,
    smooth_dau float
);


CREATE TABLE IF NOT EXISTS public.f_bugs_status_changes
(
    bug_id varchar(255),
    bug_severity varchar(255),
    bug_status_current varchar(255),
    bug_status_previous varchar(255),
    bug_version_num varchar(255),
    assigned_to varchar(255),
    component varchar(255),
    created_by varchar(255),
    created_ts timestamp,
    modified_by varchar(255),
    modified_ts timestamp,
    op_sys varchar(255),
    priority varchar(255),
    product varchar(255),
    qa_contact varchar(255),
    reported_by varchar(255),
    reporter varchar(255),
    version varchar(255),
    expires_on varchar(255),
    cf_due_date varchar(255),
    target_milestone varchar(255),
    keywords varchar(1024),
    snapshot_date date,
    load_date date,
    load_source varchar(100)
);


CREATE TABLE IF NOT EXISTS public.snippet_count_fennec
(
    utc_time varchar(255),
    local_time varchar(255),
    country_code varchar(255),
    country_name varchar(255),
    latitude varchar(255),
    longitude varchar(255),
    city varchar(255),
    domain_name varchar(255),
    org_name varchar(255),
    isp_name varchar(255),
    request_type varchar(255),
    request_url varchar(255),
    http_status_code varchar(255),
    response_size_in_bytes varchar(255),
    referring_url varchar(255),
    ua_family varchar(255),
    ua_major varchar(255),
    ua_minor varchar(255),
    os_family varchar(255),
    os_major varchar(255),
    os_minor varchar(255),
    device_family varchar(255),
    custom_field_1 varchar(255),
    custom_field_2 varchar(255),
    custom_field_3 varchar(255),
    filename varchar(255),
    snippet_id numeric(20,0),
    snippet_impression_date varchar(255)
);


CREATE TABLE IF NOT EXISTS public.user_locales
(
    raw_locale varchar(255),
    normalized_locale varchar(255)
);


CREATE TABLE IF NOT EXISTS public.redash_focus_retention
(
    os varchar(10),
    cohort date,
    week date,
    cohort_size int,
    weeK_num int,
    active_users int
);


CREATE TABLE IF NOT EXISTS public.mobile_daily_active_users
(
    app varchar(20),
    os varchar(20),
    day date,
    dau int,
    smooth_dau float,
    wau int,
    mau int,
    weekly_engagement numeric(5,2),
    monthly_engagement numeric(5,2)
);


CREATE TABLE IF NOT EXISTS public.adjust_fennec_retention_by_os
(
    date date,
    os varchar(10),
    period int,
    retention numeric(5,4)
);


CREATE TABLE IF NOT EXISTS public.adjust_ios_daily_active_users
(
    adj_date date,
    daus float,
    waus float,
    maus float
);


CREATE TABLE IF NOT EXISTS public.adjust_android_daily_active_users
(
    adj_date date,
    daus float,
    waus float,
    maus float
);


CREATE TABLE IF NOT EXISTS public.adjust_focus_daily_active_users
(
    adj_date date,
    daus float,
    waus float,
    maus float,
    installs int
);


CREATE TABLE IF NOT EXISTS public.adjust_klar_daily_active_users
(
    adj_date date,
    daus float,
    waus float,
    maus float,
    installs int
);


CREATE TABLE IF NOT EXISTS public.sf_donations
(
    opp_name varchar(20),
    amount numeric(18,2),
    contact_id varchar(50)
);


CREATE TABLE IF NOT EXISTS public.sf_foundation_signups
(
    contact_id varchar(50),
    signup_date timestamptz
);


CREATE TABLE IF NOT EXISTS public.sf_copyright_petition
(
    contact_id varchar(50),
    signed_on_date date
);


CREATE TABLE IF NOT EXISTS public.sf_contacts
(
    id varchar(50),
    created_date timestamp,
    email varchar(255),
    email_format varchar(1),
    contact_name varchar(255),
    email_language varchar(10),
    signup_source_url varchar(500),
    confirmation_miti_subscriber boolean,
    sub_apps_and_hacks boolean,
    sub_firefox_and_you boolean,
    sub_firefox_accounts_journey boolean,
    sub_mozilla_foundation boolean,
    sub_miti_subscriber boolean,
    sub_mozilla_leadership_network boolean,
    sub_mozilla_learning_network boolean,
    sub_webmaker boolean,
    sub_mozillians_nda boolean,
    sub_open_innovation_subscriber boolean,
    subscriber boolean,
    sub_test_flight boolean,
    sub_test_pilot boolean,
    sub_view_source_global boolean,
    sub_view_source_namerica boolean,
    double_opt_in boolean,
    unengaged boolean,
    email_opt_out boolean,
    mailing_country varchar(255)
);


CREATE TABLE IF NOT EXISTS public.adjust_retention
(
    date date,
    os varchar(10),
    period int,
    retention numeric(5,4),
    app varchar(10)
);


CREATE TABLE IF NOT EXISTS public.adjust_daily_active_users
(
    adj_date date,
    os varchar(10),
    daus float,
    waus float,
    maus float,
    installs int,
    app varchar(10)
);


CREATE TABLE IF NOT EXISTS public.adjust_retention_test
(
    date date,
    os varchar(10),
    period int,
    retention numeric(5,4),
    app varchar(10)
);


CREATE TABLE IF NOT EXISTS public.adjust_daily_active_users_test
(
    adj_date date,
    os varchar(10),
    daus float,
    waus float,
    maus float,
    installs int,
    app varchar(10)
);


CREATE TABLE IF NOT EXISTS public.last_updated
(
    name varchar(100) NOT NULL,
    updated_at timestamp,
    updated_by varchar(255),
    CONSTRAINT C_PRIMARY PRIMARY KEY (name) DISABLED
);

CREATE TABLE IF NOT EXISTS public.ut_desktop_daily_active_users
(
    day date,
    mau int,
    dau int,
    smooth_dau float,
    engagement_ratio numeric(5,2)
);


CREATE TABLE IF NOT EXISTS public.opt_dates
(
    date_id int NOT NULL,
    year int,
    month int,
    day_of_year int,
    day_of_month int,
    day_of_week int,
    week_of_year int,
    day_of_week_desc varchar(10),
    day_of_week_short_desc varchar(3),
    month_desc varchar(10),
    month_short_desc varchar(3),
    quarter int,
    is_weekday varchar(1),
    date date,
    CONSTRAINT C_PRIMARY PRIMARY KEY (date_id) DISABLED
);

CREATE TABLE IF NOT EXISTS public.country_names
(
    code varchar(10),
    country varchar(100)
);


CREATE TABLE IF NOT EXISTS public.copy_adi_dimensional_by_date
(
    _year_quarter varchar(7),
    bl_date date,
    product varchar(20),
    v_prod_major varchar(7),
    prod_os varchar(50),
    v_prod_os varchar(50),
    channel varchar(100),
    locale varchar(50),
    continent_code varchar(2),
    cntry_code varchar(2),
    tot_requests_on_date int,
    distro_name varchar(100),
    distro_version varchar(100),
    buildid varchar(20) DEFAULT ''
);
