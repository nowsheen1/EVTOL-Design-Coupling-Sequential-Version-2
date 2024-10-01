% Function that loads the configuration sizing trade study results and
% generates some interesting plots 


% Constants
km2m = 1000;

%% Load trade study data
load('tradeStudyResults.mat');

%% Save data in usable format
ranges = ranges';
mH = nan(length(ranges),1); % Helicopter mass
mT = nan(length(ranges),1); % Tilt-wing mass
mBatH = nan(length(ranges),1); % Helicopter battery mass
mBatT = nan(length(ranges),1); % Tilt-wing battery mass
vH = nan(length(ranges),1); % Helicopter cruise speed
vT = nan(length(ranges),1); % Tilt-wing cruise speed
bH = nan(length(ranges),1); % Helicopter span
bT = nan(length(ranges),1); % Tilt-wing span
lH = nan(length(ranges),1); % Helicopter length
lT = nan(length(ranges),1); % Tilt-wing length
cH = nan(length(ranges),1); % Helicopter DOC per flight
cT = nan(length(ranges),1); % Tilt-wing DOC per flight
rH = nan(length(ranges),1); % Helicopter rotor radius
rT = nan(length(ranges),1); % Tilt-wing fan radius
pHH = nan(length(ranges),1); % Helicopter hover power
pHT = nan(length(ranges),1); % Tilt-wing hover power
pCH = nan(length(ranges),1); % Helicopter cruise power
pCT = nan(length(ranges),1); % Tilt-wing cruise power
mBreakdownH = nan(length(ranges),7); % Helicopter mass breakdown
mBreakdownT = nan(length(ranges),7); % Tilt-wing mass breakdown
CBreakdownH = nan(length(ranges),6); % Helicopter cost breakdown
CBreakdownT = nan(length(ranges),6); % Tilt-wing cost breakdown

% Loop through results and pack vectors
for i = 1:length(ranges)
    km2m = 1000;
%     if length(CHelicopter) >= i
%         if ~isempty(massHelicopter(i).m) 
%             mH(i) = massHelicopter(i).m; 
%         end
%         if ~isempty(massHelicopter(i).battery)
%             mBatH(i) = massHelicopter(i).battery; 
%         end
%         vH(i) = VHelicopter(i);
%         bH(i) = 2 * rPropHelicopter(i);
%         lH(i) = 2.25 * rPropHelicopter(i);
%         rH(i) = rPropHelicopter(i);
%         pHH(i) = hoverOutputHelicopter(i).PBattery * 1e-3;
%         pCH(i) = cruiseOutputHelicopter(i).PBattery * 1e-3;
%         mBreakdownH(i,:) = 1.1*[massHelicopter(i).payload, massHelicopter(i).avionics + ...
%             massHelicopter(i).servos + massHelicopter(i).wire, ...
%             massHelicopter(i).seat + massHelicopter(i).brs, ...
%             massHelicopter(i).battery, massHelicopter(i).motors + massHelicopter(i).transmission, ...
%              massHelicopter(i).structural];
%         CBreakdownH(i,:) = [CHelicopter(i).acquisitionCostPerFlight,...
%             CHelicopter(i).insuranceCostPerFlight,...
%             CHelicopter(i).facilityCostPerFlight,...
%             CHelicopter(i).energyCostPerFlight,...
%             CHelicopter(i).batteryReplCostPerFlight + CHelicopter(i).motorReplCostPerFlight + CHelicopter(i).servoReplCostPerFlight, ...
%             CHelicopter(i).laborCostPerFlight];
%         if ~isempty(CHelicopter(i).costPerFlight); cH(i) = CHelicopter(i).costPerFlight; end;
%     end
    if length(CTiltWing) >= i
        if ~isempty(massTiltWing(i).m)
            mT(i) = massTiltWing(i).m; 
        end
        if ~isempty(massTiltWing(i).battery)
            mBatT(i) = massTiltWing(i).battery; 
        end
        vT(i) = VTiltWing(i);
        bT(i) = 8 * rPropTiltWing(i) + 1;
        lT(i) = 4 * rPropTiltWing(i) + 3;
        rT(i) = rPropTiltWing(i);
        pHT(i) = hoverOutputTiltWing(i).PBattery * 1e-3;
        pCT(i) = cruiseOutputTiltWing(i).PBattery * 1e-3;
        mBreakdownT(i,:) = 1.1*[massTiltWing(i).payload, massTiltWing(i).avionics + ...
            massTiltWing(i).servos + massTiltWing(i).wire + massTiltWing(i).tilt, ...
            massTiltWing(i).seat + massTiltWing(i).brs, ...
            massTiltWing(i).battery, massTiltWing(i).motors,massTiltWing(i).gearbox, ...
             massTiltWing(i).structural];
         CBreakdownT(i,:) = [CTiltWing(i).acquisitionCostPerFlight,...
            CTiltWing(i).insuranceCostPerFlight,...
            CTiltWing(i).facilityCostPerFlight,...
            CTiltWing(i).energyCostPerFlight,...
            CTiltWing(i).batteryReplCostPerFlight + CTiltWing(i).motorReplCostPerFlight + CTiltWing(i).servoReplCostPerFlight, ...
            CTiltWing(i).laborCostPerFlight];
        if ~isempty(CTiltWing(i).costPerFlight); cT(i) = CTiltWing(i).costPerFlight; end;
    end
end





%% Mass Breakdown
figuren('Mass Breakdown'); clf;
% subplot(2,1,1); hold on;
% bar(ranges/km2m, mBreakdownH,'stacked')
% xlim([0,210])
% ylim([0,2000])
% grid on
% xlabel('Range [km]')
% ylabel('Mass [kg]')
% title('Electric Helicopter')
% legend('Payload','Avionics','Misc','Battery','Motors+Transmission','Structure','Location','Best')


%bar(ranges/km2m, mBreakdownT, 'stacked')
subplot(1,2,1);hold on;
bar(ranges/km2m, mBreakdownT, 'stacked');
grid on
xlabel('Range [km]')
ylabel('Mass [kg]')
title('Electric Tilt-Wing SAND')
ylim([0,700]);
%saveas(gcf,'./massBreakdown','png');
legend('Payload','Avionics','Misc','Battery','Motors','Transmission','Structure','Location','Best')

massTiltWing_atc=atc_mass(atc.x0(:,1));
mBreakdownT_atc = plotTradeResults_atc();
subplot(1,2,2);hold on;

bar(ranges/km2m, mBreakdownT_atc, 'stacked');
grid on
xlabel('Range [km]')
ylabel('Mass [kg]')
title('Electric Tilt-Wing ATC')
%saveas(gcf,'./massBreakdown','png');
legend('Payload','Avionics','Misc','Battery','Motors','Transmission','Structure','Location','Best')
ylim([0,700]);
