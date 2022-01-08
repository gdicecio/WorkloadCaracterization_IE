clc; clear all; close all;

%% 
SensitivityTuple('FilterBG-Node/R63-M0-N0-BGLErrorLog.txt','tentative-Cwin.txt') %i valori di cwin li possiamo anche cambiare

%% Blue-Gene Nodes
subplot(3,3,1);
SensitivityTuple('MercuryErrorLog.txt','tentative-Cwin.txt') %i valori di cwin li possiamo anche cambiare

subplot(3,3,2);
SensitivityTuple('BGLErrorlog.txt','tentative-Cwin.txt')



