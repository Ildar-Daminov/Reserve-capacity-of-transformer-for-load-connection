clc
clear all
close all

%% Goal of the script
% This scripts reproduces the Figures from the conference paper [1]:

% If you use this code, please cite this conference paper:
% [1] Ildar Daminov, Anton Prokhorov,Tatiana Moiseeva, Marie-Cécile
% Alvarez-Hérault, Raphaël Caire,  "Application of dynamic transformer
% ratings to increase the reserve of primary substations for new load
% interconnection" in CIRED 2019, https://hal.archives-ouvertes.fr/hal-02186079

% Other articles on this topic are available:
% https://www.researchgate.net/profile/Ildar-Daminov-2

% Note that the figures generated in this script and those given in the
% article may differ as latter had been additionally redrawn
% for a publication.

% Each section (Plotting the Figure X) is independent from each other. So
% you may launch the entire script (using the button "Run") to get all
% figures at one moment or you may launch a special section (using the
% button "Run Section" at the top)to get a specific figure

% Execution time of entire script ≈ 20 seconds

tic
%% Plotting the Figure 1
% Figure name:  Historical ambient temperature over 30 years in Tomsk
% (Siberia, Russia)

clc;clear all % clear a command window and a workspace

% Load T - historical ambient temperature (among others)
% from Jan 1, 1985 to 6 Jan 2019 (MeteoBlue data):
load('T_history_Tomsk.mat') % in Tomsk, Russia

% Extracting the ambient temperature
AMB_Tomsk=T(:,6);

% Round ambient temperature
AMB_Tomsk=round(AMB_Tomsk);


% Create figure
figure('InvertHardcopy','off','Color',[1 1 1]);

% Prepare a time vector
t1 = datetime(1985,1,1,0,0,0,'Format','HH:SS');
t2 = datetime(2019,1,6,23,59,0,'Format','HH:SS');
time = t1:hours(1):t2;

% plotting the ambient temperature in Tomsk
plot(time,AMB_Tomsk,'LineWidth',2)
ylabel('Ambient temperature,°C')
title('Ambient temperature in Tomsk over 30 years')

%% Plotting the Figure 2
% Figure name: Probability density function with confidenceinterval 100%
% for September in Tomsk (Siberia, Russia)

clc;clear all % clear a command window and a workspace

% Load T - historical ambient temperature (among others)
% from Jan 1, 1985 to 6 January 2019 (MeteoBlue data):
load('T_history_Tomsk.mat') % in Tomsk, Russia

% Creating the vector of months names
months={'January', 'February'...
    'March', 'April', 'May', 'June', 'July', 'August', 'September'...
    'October', 'November', 'December'};

% create figure
figure('InvertHardcopy','off','Color',[1 1 1],'DefaultAxesFontSize',14);

% Build figure
for month=1:12
    try % try the code below. Otherwise see "catch" below
        % Find data beloning to specific month
        index=find((T(:,2)==month));
        
        % Round temperature beloning to specific month
        rounded_month_temperature=round(T(index,6));
        
        % Find the unique values of ambient temperature
        unique_values = unique(rounded_month_temperature);
        
        % Count the histogram
        out = [unique_values,histc(rounded_month_temperature(:),unique_values)];
        
        % Convert the data (of future y-axis) to percent
        out(:,2)=out(:,2)/length(rounded_month_temperature)*100;
        
        % Find the indexes of maximal
        maxind=find(out(:,2)==max(out(:,2)));
        
        % If few maximum exist
        if ~(length(maxind)==1)
            maxind=(maxind(1)+maxind(2))/2;
        end
        
        % Make a bar plot
        subplot(3,4,month)
        bar(out(:,1),out(:,2))
        xlabel('Temperatures, °C');
        ylabel('PDF');
        title(['PDF for ', months{month}]);
        
        % Save a maximal monthly temperature
        Max_monthly_AMB(month,1)=max(unique_values);
        
    catch % if any problem, print the message
        
        fprintf('Error in for cycle \n')
        fprintf ('See i=%d \n',month);
        
    end % end of try
    
end % end of for cycle

%% Plotting the Figure 3
% Figure name: The graph with the highest ambient temperature

clc;clear all % clear a command window and a workspace

% Load T - historical ambient temperature (among others)
% from Jan 1, 1985 to 6 January 2019 (MeteoBlue data):
load('T_history_Tomsk.mat') % in Tomsk, Russia

% Creating the vector of months names
months={'January', 'February'...
    'March', 'April', 'May', 'June', 'July', 'August', 'September'...
    'October', 'November', 'December'};

% Extract monthly maximums of ambient temperatures
for month=1:12
    try % try the code below. Otherwise see "catch" below
        % Find data beloning to specific month
        index=find((T(:,2)==month));
        
        % Round temperature beloning to specific month
        rounded_month_temperature=round(T(index,6));
        
        % Find the unique values of ambient temperature
        unique_values = unique(rounded_month_temperature);
        
        
        % Save a maximal monthly temperature
        Max_monthly_AMB(month,1)=max(unique_values);
        
    catch % if any problem, print the message
        
        fprintf('Error in for cycle \n')
        fprintf ('See i=%d \n',month);
        
    end % end of try
    
end % end of for cycle


% Convert vector of 12x1 to minute resolution

AMB_minute_resolution=NaN;
for month=1:12 % for each month
    
    if month==2 % february (28 days). Leap year (29 days in Feb) is not considered!
        minutes_in_month=28*24*60;
        AMB_minute_resolution(end+1:end+minutes_in_month,1)=Max_monthly_AMB(month,1);
        
    elseif month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12
        
        % month has 31 days
        minutes_in_month=31*24*60;
        AMB_minute_resolution(end+1:end+minutes_in_month,1)=Max_monthly_AMB(month,1);
        
    else % if month has 30 days
        minutes_in_month=30*24*60;
        AMB_minute_resolution(end+1:end+minutes_in_month,1)=Max_monthly_AMB(month,1);    end
    
end % end of for cycle

AMB_minute_resolution(1,:)=[];% delete the first value

% create figure
figure('InvertHardcopy','off','Color',[1 1 1],'DefaultAxesFontSize',14);

% Prepare a time vector
t1 = datetime(2019,1,1,0,0,0,'Format','HH:SS');
t2 = datetime(2019,12,31,23,59,0,'Format','HH:SS');
time = t1:minutes(1):t2;

plot(time, AMB_minute_resolution,'LineWidth',2)

ylabel('Ambient temperature, °C');
xlabel('Time');

legend('Maximal ambient temperature ')


%% Plotting the Figure 4
% Figure name: Annual constant load profile of new consumeras assumption
% for thermal modelling

clc;clear all % clear a command window and a workspace

% Prepare a time vector
t1 = datetime(2019,1,1,0,0,0,'Format','HH:SS');
t2 = datetime(2019,12,31,23,59,0,'Format','HH:SS');
time = t1:minutes(1):t2;

% Create a vector
Constant_load=linspace(1,1,length(time)); % in pu relative to transformer rating

% create figure
figure('InvertHardcopy','off','Color',[1 1 1],'DefaultAxesFontSize',14);

% Plot a figure
plot(time,Constant_load,'LineWidth',2)

ylabel('Load, per unit');
xlabel('Time');

title('Load profile assumption for new consumer')

%% Plotting the Figure 5
% Figure name: Initial load profile of primary substation and reference
% ambient temperature graph in Tomsk

clc;clear all % clear a command window and a workspace

% Load annual power and ambient temperature profiles
load('Initial_Data.mat')
% PUL - per unit load at anonymized substation in N-1 condition
% AMB - monthly maximums of ambient temperature in Tomsk (see the section
% 'Plotting Figure 3' to understand how it was built)

% Create figure
figure;

% Create axes
axes1 = axes;
hold(axes1,'on');
colororder([0 0.447 0.741]);

% Activate the left side of the axes
yyaxis(axes1,'left');
% Create plot
plot(time,PUL,'LineWidth',1);

% Create ylabel
ylabel('Transformer loading in N-1,pu');

% Set the remaining axes properties
set(axes1,'YColor',[0 0.447 0.741]);

% Activate the right side of the axes
yyaxis(axes1,'right');

% Create plot
plot(time,AMB,'LineWidth',3,'Color',[0.85 0.325 0.098]);

% Create ylabel
ylabel('Ambient temperature,℃');

% Set the remaining axes properties
set(axes1,'YColor',[0.85 0.325 0.098]);
box(axes1,'on');
hold(axes1,'off');

% Set the remaining axes properties
set(axes1,'FontSize',20,'LineStyleOrderIndex',2,'XGrid','on');

%% Plotting the Figure 6 and 7
% Figure 6 name: Initial load profile (blue) and the same loadprofile after
% adding reserve (orange)

% Figure 7 name: ST plot and corresponding LoL (Loss of Life)

clc;clear all % clear a command window and a workspace

% Load annual power and ambient temperature profiles
load('Initial_Data.mat')
% PUL - per unit load at anonymized substation in N-1 condition
% AMB - monthly maximums of ambient temperature in Tomsk (see the section
% 'Plotting Figure 3' to understand how it was built)


%---------------- Tradtional approach to define transformer headroom-------
Headroom_conventional=1 - max(PUL); % nominal rating - peak load in N-1 mode

%---------------------------- Proposed approach----------------------------

% Save the initial load profile
PUL_init=PUL;

% Initial HST profile and ageing
evalc('[HST_init,~,AEQ_init]=ONAF_transformer(PUL_init,AMB);');


% Save the results
result.HST=max(HST_init);
result.AEQ=AEQ_init;
result.max_load=max(PUL_init);
result.headroom=Headroom_conventional;

% Set desired HST limit and ageing limit
HST_limit=120; %°C
Ageing_limit=1;% pu i.e. normal ageing limit

%%%% Find the approximative admissible loading%%%%

% Note that at this stage the approximative admissible loading may take
% any value. The final value would be corrected later (during for cycle
% below). So, this section is not strict to follow

% Dependency betweeen Loading and HST at 30 (IEC)
Loading_table=[0.1:0.1:2]';
HST_table = [44.2171;46.9284; 51.0084; 56.3014; 62.6822; 70.0500; 78.3244;
    87.4410; 97.3473; 108.0000; 119.3628; 131.4049; 144.0995; 157.4232;
    171.3554; 185.8778; 200.9737; 216.6282; 232.8276; 249.5593];

% Find index idx of the closest value to HST limit
[~, idx]= min(abs(HST_table-HST_limit));

% Headroom for AMB=30 ℃
Admissible_loading=Loading_table(idx);

% Correct Admissible_power_prelim to AMB when max(PUL) has taken place
% In reality, max load could take place for few times. Thus, highest AMB
% must be considered

%Index when Load is max
index_maxPUL=find(PUL_init==max(PUL_init));

% Find delta corresponding to AMB (+1℃) where peak load happens
delta=AMB(index_maxPUL(1))-30; % difference in ambient temperature
if delta>0 % if difference is positive
    delta_headroom=-abs(delta)*0.01;
elseif delta<0 % if difference is negative
    delta_headroom=abs(delta)*0.0075;
elseif delta==0 % no difference
    delta_headroom=0;
end % end of "if"

% Evaluate max admissible load
Admissible_loading=Admissible_loading+delta_headroom;

% Headroom with Pmax approach
headroom=Admissible_loading-max(PUL_init);

% Estimate the new load profile (with new load connected)
PUL=PUL_init+headroom;

% Create figure
figure('InvertHardcopy','off','Color',[1 1 1]);

% Create axes
axes1 = axes;
hold(axes1,'on');

% Prepare a time vector
t1 = datetime(2019,1,1,0,0,0,'Format','HH:SS');
t2 = datetime(2019,12,31,23,59,0,'Format','HH:SS');
time = t1:minutes(1):t2;

% Create multiple lines using matrix input to plot
plot1 = plot(time,[PUL_init PUL],'LineWidth',1);
set(plot1(1),'DisplayName','Initial load profile');
set(plot1(2),'DisplayName','Initial load profile +reserve');

% Create ylabel
ylabel('Transformer loading, pu','FontSize',17.6);

% Create xlabel
xlabel('Time','FontSize',17.6);

% Create title
title('Initial load profile in N-1 mode and reserve ');

% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0.2 1.4]);
% Uncomment the following line to preserve the Z-limits of the axes
% zlim(axes1,[-1 1]);
box(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'FontSize',16);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.458724636877509 0.694082573305698 0.180120170689426 0.0778193342671982],...
    'EdgeColor',[1 1 1]);

% Estimate HST and Ageing for given headroom
[HST,TOT,AEQ]=ONAF_transformer(PUL,AMB);


% Create figure
figure;

% Create axes
axes1 = axes('Position',...
    [0.13 0.138602520045819 0.768496240601504 0.786397479954181]);
hold(axes1,'on');

HST_limit=linspace(120,120,length(PUL));
HST_limit=HST_limit';

% Create multiple lines using matrix input to plot
plot1 = plot(time,[HST,HST_limit]);
set(plot1(1),'DisplayName','HST','LineWidth',1);
set(plot1(2),'DisplayName','HST limit','LineWidth',3);

% Create ylabel
ylabel('Hot spot temperature of windings, ℃');

% Create xlabel
xlabel('Time');

% Create title
title('Hot spot temperature with \color{Darkgreen}ageing acceleration factor=0.10136');

% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[60 130]);
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'FontSize',20,'YColor',[0 0.447 0.741],'YTick',[60 80 100 120]);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.466647824019293 0.635308865384986 0.0970480683953536 0.0939298064579761],...
    'EdgeColor',[1 1 1]);

HST_limit=120; % ℃

% Correcting the headroom
delta=0.01; % delta for headroom adjusting

% Algorithm 

if AEQ>Ageing_limit || max(HST)>HST_limit
    
    while AEQ>1||max(HST)>HST_limit
        headroom=headroom-delta;
        PUL=PUL_init+headroom;
        evalc('[HST,TOT,AEQ]=ONAF_transformer(PUL,AMB);');
    end % end of "while"
    
else % if  AEQ<=Ageing_limit || max(HST)<=HST_limit
    while ~(AEQ>Ageing_limit || max(HST)>HST_limit)
        headroom=headroom+delta;
        PUL=PUL_init+headroom;
        evalc('[HST,TOT,AEQ]=ONAF_transformer(PUL,AMB);');
        result.HST(end+1,1)=max(HST);
        result.AEQ(end+1,1)=AEQ;
        result.max_load(end+1,1)=max(PUL);
        result.headroom(end+1,1)=headroom;
    end % end of "while"
end % end of "if"

Final_headroom=result.headroom(end-1,1) % in pu
Final_headroom_MVA=result.headroom(end-1,1)*25 % in MVA 