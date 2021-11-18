clc; clear all; close all;

Theta=[0;0;0];
G = [1.7;2.9;17.28];
L1 = 4.07;
L2 = 11.05;
L3 = 4.21;
tic
Theta = cinematicainvdeg(G,Theta)
toc