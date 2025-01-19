function main()
% ustalamy nzawy plików z danymi
nazwaPliku = 'test1__calibration_p300.obci';
nameOfXMLFile = strcat(nazwaPliku,'.xml');
nameOfTagFile = strcat(nazwaPliku,'.tag'); %tagi = znaczniki zdarzeń
namesOfDataFiles = strcat(nazwaPliku,'.raw');
PRE = -0.2; % czas przed tagiem w sek.
POST = 0.8; % czas po tagu w sek
[TargetSignal, NonTargetSignal, ~,time]= readData(nameOfXMLFile,namesOfDataFiles,nameOfTagFile, PRE, POST );

P3_idx = time>0.15& time<550;
N_buff = 8;

[W,~]  = CSP_fit(TargetSignal, NonTargetSignal);

[S_T, S_NT] = get_CSP_sources(TargetSignal,NonTargetSignal, W);
DS1 = get_dataSet(S_T, S_NT, N_buff, P3_idx);
plot_features(DS1);
X=DS1.X;
Y=DS1.Y;
save('p300_DS1.mat','X','Y')


nazwaPliku = 'test2__calibration_p300.obci';
nameOfXMLFile = strcat(nazwaPliku,'.xml');
nameOfTagFile = strcat(nazwaPliku,'.tag'); %tagi = znaczniki zdarzeń
namesOfDataFiles = strcat(nazwaPliku,'.raw');
[TargetSignal, NonTargetSignal, ~,time]= readData(nameOfXMLFile,namesOfDataFiles,nameOfTagFile, PRE, POST );
[S_T, S_NT] = get_CSP_sources(TargetSignal,NonTargetSignal, W);
DS2 = get_dataSet(S_T, S_NT, N_buff, P3_idx);
plot_features(DS2);
X=DS2.X;
Y=DS2.Y;
save('p300_DS2.mat','X','Y')

nazwaPliku = 'test3__calibration_p300.obci';
nameOfXMLFile = strcat(nazwaPliku,'.xml');
nameOfTagFile = strcat(nazwaPliku,'.tag'); %tagi = znaczniki zdarzeń
namesOfDataFiles = strcat(nazwaPliku,'.raw');
[TargetSignal, NonTargetSignal, ~,time]= readData(nameOfXMLFile,namesOfDataFiles,nameOfTagFile, PRE, POST );
[S_T, S_NT] = get_CSP_sources(TargetSignal,NonTargetSignal, W);
DS3 = get_dataSet(S_T, S_NT, N_buff, P3_idx);
plot_features(DS3);
X=DS3.X;
Y=DS3.Y;
save('p300_DS3.mat','X','Y')
end

function [TargetSignal, NonTargetSignal, numberOfChannels,time  ]= readData(nameOfXMLFile,namesOfDataFiles,nameOfTagFile, PRE, POST )
%
%PRE = -0.2; % czas przed tagiem w sek.
%POST = 0.8; % czas po tagu w sek

% inicjujemy obiekt rm
rm = ReadManager(nameOfXMLFile,namesOfDataFiles,nameOfTagFile);

% obieramy przydatne parametry i znaczniki
%numberOfChannels  = rm.get_param('number_of_channels');
numberOfChannels =21;
%namesOfChannels   = rm.get_param('channels_names');
samplingFrequency = rm.get_param('sampling_frequency');
tagsStruct        = rm.get_tags();

% tworzenie list znaczników Target i NonTarget
numberOfStruct = length(tagsStruct);
targetTimeStamps = [];
NonTargetTimeStamps = [];
for structNumber = 1:numberOfStruct % iterujemy się przez tagi
    if(strcmp(tagsStruct(structNumber).name,'blink')) % szukamy tagów o nazwie 'blink'
        index = tagsStruct(structNumber).children.index; % tu jest numer pola stymulacji
        target= tagsStruct(structNumber).children.target;% tu jest numer pola na którym wyświetlany jest target
        if index == target % warunek na to, że mamy do czynienia z tagiem target
            targetTimeStamps = [targetTimeStamps tagsStruct(structNumber).start_timestamp]; %dodajemy timeStamp do listy targetów
        else
            NonTargetTimeStamps = [NonTargetTimeStamps tagsStruct(structNumber).start_timestamp];%dodajemy timeStamp do listy non-targetów
        end
        
    end
end


% pobieramy próbki
samples = double(rm.get_samples()); % konwersja na double jest potrzebna żeby dobrze funkcjonowało filtrowanie
samples=samples(1:numberOfChannels,:); % odrzucamy kanały, które nie mają EEG


% filtrujemy dolnoprzepustowo aby odrzucić artefakty sieci i część
% artefaktów mięśniowych
[b,a] = cheby2(6,80,15 /(samplingFrequency/2),'low');
for ch = 1:numberOfChannels
    samples(ch,:)=filtfilt(b,a,samples(ch,:));
end

% montujemy dane do wspólnej średniej (common average)
M = -ones(numberOfChannels,numberOfChannels)/numberOfChannels;
M=M+eye(numberOfChannels,numberOfChannels)*(numberOfChannels+1)/numberOfChannels;
samples = 0.0715*M*samples;

% wycinamy dane wokół znaczników

wycinek = floor(PRE*samplingFrequency:POST*samplingFrequency); % tablica ze "standardowymi" indeksami do cięcia
time = wycinek/samplingFrequency;

% pobieramy targety
TargetSignal = zeros(length(targetTimeStamps),numberOfChannels, length(wycinek)); % tablica na sygnały target
for trialNumber = 1:length(targetTimeStamps)
    trigerOnset = floor(targetTimeStamps(trialNumber)*samplingFrequency);
    tenWycinek = wycinek + trigerOnset;
    if tenWycinek(1)>0 && tenWycinek(end)<=size(samples,2) % test czy wycinek który chcemy pobrać nie wystaje poza dostępny sygnał
        tmpSignal = samples(:,tenWycinek);
        tmpSignal = detrend(tmpSignal')'; % usuwanie liniowego trendu - przy krótkich wycinkach działa lepiej niż filtrowanie górnoprzepustowe
        TargetSignal(trialNumber, :,:) = tmpSignal;
    end
end

% pobieramy non-targety
NonTargetSignal = zeros(length(NonTargetTimeStamps),numberOfChannels, length(wycinek));% tablica na sygnały non-target
for trialNumber = 1:length(NonTargetTimeStamps)
    trigerOnset = floor(NonTargetTimeStamps(trialNumber)*samplingFrequency);
    tenWycinek = wycinek + trigerOnset;
    if tenWycinek(1)>0 && tenWycinek(end)<=size(samples,2)
        tmpSignal = samples(:,tenWycinek);
        tmpSignal = detrend(tmpSignal')';
        NonTargetSignal(trialNumber, :,:) = tmpSignal;
    end
end

end

function [W,Lambda]= CSP_fit(TargetSignal, NonTargetSignal)
% liczymy �rednie macierze kowariancji:
[numberOfTargets,~,~] = size(TargetSignal);
[numberOfnonTargets,numberOfChannels,~] = size(NonTargetSignal);
R_E = zeros(numberOfChannels,numberOfChannels);
R_B = zeros(numberOfChannels,numberOfChannels);
for trialNumber =1:numberOfTargets
    B = squeeze(TargetSignal(trialNumber,:,:));
    tmpCov = B*B';
    R_B = R_B + tmpCov/trace(tmpCov)  ;
end
R_B = R_B/numberOfTargets;

for trialNumber = 1:numberOfnonTargets
    E = squeeze(NonTargetSignal(trialNumber,:,:));
    tmpCov =  E*E';
    R_E = R_E + + tmpCov/trace(tmpCov)  ;
end
R_E = R_E/numberOfnonTargets;

% rozwi�zujemy uog�lnione zagadnienie w�asne
[W,Lambda]=eig(R_B,R_E); % mo�liwa jest te� otymalizacja wzg. �redniej macierzy kowariancji (R_B+R_A)/2);

end

function [S_T, S_NT] = get_CSP_sources(TargetSignal,NonTargetSignal, W)
[numberOfTargets,~,~] = size(TargetSignal);
[numberOfnonTargets,~,~] = size(NonTargetSignal);

% odzyskujemy sygna�y �r�de�
S_T = zeros(size(TargetSignal));
for trialNumber =1:numberOfTargets
    S_T(trialNumber,:,:) = W'*squeeze(TargetSignal(trialNumber,:,:));
end

S_NT = zeros(size(NonTargetSignal));
for trialNumber =1:numberOfnonTargets
    S_NT(trialNumber,:,:) = W'*squeeze(NonTargetSignal(trialNumber,:,:));
end
end

function DS = get_dataSet(S_T, S_NT, N_buff,P3_idx)
% u�redniam po N_buff powt�rze�

[numberOfTargets,~,~] = size(S_T);
[numberOfnonTargets,numberOfChannels,~] = size(S_NT);
% wyliczam cechy

DS.X = [];%zeros(size(S_T,1) + size(S_NT,1) -2*N_buff, numberOfChannels );
DS.Y = [];%zeros(size(S_T,1) + size(S_NT,1) -2*N_buff,1 );

trialCount = 1;
S_T_av = zeros(size(S_T,1)-N_buff , size(S_T,2),size(S_T,3));
for trialNumber =1:N_buff:numberOfTargets-N_buff
    S_T_av(trialNumber,:,:) = mean(S_T(trialNumber:trialNumber+N_buff,:,:),1);
    for ch = 1:numberOfChannels
        DS.X(trialCount, ch) = var(S_T_av(trialNumber,ch  ,P3_idx),[],3);
        DS.Y(trialCount) = 1; % 1 -> target
    end
    trialCount =trialCount+1;
end

S_NT_av = zeros(size(S_NT,1)-N_buff , size(S_NT,2),size(S_NT,3));
for trialNumber =1:N_buff:numberOfnonTargets-N_buff
    S_NT_av(trialNumber,:,:) = mean(S_NT(trialNumber:trialNumber+N_buff,:,:),1);
    for ch = 1:numberOfChannels
        DS.X(trialCount, ch) = var(S_NT_av(trialNumber,ch  ,P3_idx),[],3);
        DS.Y(trialCount) = 0; % 0 -> non-target
    end
    trialCount =trialCount+1;
end
end

function plot_features(DS)
idx_Target= find(DS.Y ==1);
idx_nonTarget= find(DS.Y ==0);
numberOfChannels = size(DS.X,2);
figure()
for ch1 = 1:numberOfChannels
    
    subplot(5,5,ch1)
    title(['ch1= ', num2str(ch1)] )
    plot(idx_Target,DS.X(idx_Target,ch1), '.r');
    hold on
    plot(idx_nonTarget,DS.X(idx_nonTarget,ch1), '.b');
end

end

