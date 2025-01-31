clc, close all, clear all;

%% Mercury
N = length(load("tupling_MercuryErrorLog-150/interarrivals.txt")) + 1;
base_path = 'tupling_MercuryErrorLog-150/tuple_';
node_list = [""];   %lista temporanea dove salviamo i nodi rilevati in una tupla
nodes_mercury = [""]; %conterr� tutti i nodi del logfile mercury (ripetuti una sola volta)
j=1;
k=1;
o=1;
for i=1:N
    path = strcat(base_path,num2str(i, '%d'));
    current_file = fopen(path, 'r');
    while feof(current_file)==0
        row = fgetl(current_file);
        row_splitted = split(row);
        node = row_splitted(2);
        if contains(node_list, convertCharsToStrings(cell2mat(node)))==0
            node_list(j) = convertCharsToStrings(cell2mat(node));
            j = j+1;
        end
        if contains(nodes_mercury, convertCharsToStrings(cell2mat(node)))==0
            nodes_mercury(o) = convertCharsToStrings(cell2mat(node));
            o = o+1;
        end
    end
    if length(node_list) > 1    % se nella tupla abbiamo entries provenienti da piu di un nodo
        file_list_mercury(k) = i;   %salviamo l'indice della tupla nel file list
        k = k+1;
    end
    node_list = [""];
    j=1;
    closeresult = fclose(current_file);
end

%% BGL
N = length(load("tupling_BGLErrorLog-150/interarrivals.txt")) + 1;
base_path = 'tupling_BGLErrorLog-150/tuple_';
node_list = [""];
nodes_bgl = [""];
j=1;
k=1;
o = 1;
for i=1:N
    path = strcat(base_path,num2str(i, '%d'));
    current_file = fopen(path, 'r');
    while feof(current_file)==0
        row = fgetl(current_file);
        row_splitted = split(row);
        node = row_splitted(2);
        if contains(node_list, convertCharsToStrings(cell2mat(node)))==0
            node_list(j) = convertCharsToStrings(cell2mat(node));
            j = j+1;
        end
        
        if contains(nodes_bgl, convertCharsToStrings(cell2mat(node)))==0
            nodes_bgl(o) = convertCharsToStrings(cell2mat(node));
            o = o+1;
        end
    end
    if length(node_list) > 1
        file_list_bgl(k) = i;
        k = k+1;
    end
    node_list = [""];
    j=1;
    closeresult = fclose(current_file);
end

%% Grafico
tupla = 350;
%tupla = 373;

%nodes_mercury = ["tg-c401", "tg-master","tg-c572","tg-s044","tg-c238","tg-c242","tg-c648","tg-login3","tg-c117","tg-c669","tg-c196","tg-c128"];
%nodes_bgl = ["R71-M0-N4", "R12-M0-N0","R63-M0-N2","R03-M1-NF","R63-M0-N0","R36-M1-N0","R62-M0-N4","R63-M0-NC","R63-M0-N8","R63-M0-N4"];

%values = 1:length(nodes_mercury);
%map_mercury = containers.Map(nodes_mercury,values);
values = 1:length(nodes_bgl);
map_bgl = containers.Map(nodes_bgl,values);

base_path = 'tupling_BGLErrorLog-150/tuple_';
path = strcat(base_path,num2str(tupla, '%d'));
hold on;
current_file = fopen(path, 'r');
while feof(current_file)==0
    row = fgetl(current_file);
    row_splitted = split(row);
    timestamp = str2num(convertCharsToStrings(cell2mat(row_splitted(1))));
    current_node = map_bgl(convertCharsToStrings(cell2mat(row_splitted(2))));
    plot(timestamp, current_node, '-*b');
end
grid;
xlabel('Timestamp');
ylabel('Nodo');
title('BG/L (tupla 350)');

