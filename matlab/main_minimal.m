%     « Copyright (c) 2016, Elise Koeniguer, Aurélien Plyer (Onera) » 
%     This file is part of GeFolki.
% 
%     GeFolki is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     GeFolki is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with GeFolki in the file copying.txt.  
%     If not, see <http://www.gnu.org/licenses/gpl.txt>.
%
% ------------------------------------------------------------------------
%
%     GeFolki est un logiciel libre ; vous pouvez le redistribuer ou le
%     modifier suivant les termes de la GNU General Public License telle
%     que publiée par la Free Software Foundation ; soit la version 3 de la
%     licence, soit (à votre gré) toute version ultérieure.
% 
%     GeFolki est distribué dans l'espoir qu'il sera utile, mais SANS
%     AUCUNE GARANTIE ; sans même la garantie tacite de QUALITÉ MARCHANDE
%     ou d'ADÉQUATION à UN BUT PARTICULIER. Consultez la GNU General Public
%     License pour plus de détails.
% 
%     Vous devez avoir reçu une copie de la GNU General Public License en
%     même temps que Gefolki dans le fichier copying.txt ; si ce n'est pas
%     le cas, consultez % <http://www.gnu.org/licenses/gpl.txt



%% -------- Open all data     ---------------------------------------------
tic;

Iradar=imread('../datasets/radar_bandep.png','png');            	% RGB image in Pauli basis
Ioptique=imread('../datasets/optiquehr_georef.png','png');      	% aerial photography (RGB)
Ilidar=imread('../datasets/lidar_georef.png','png');            	% LIDAR 
load ('../datasets/radar_bandel_hh1')                           	% L-band Radar SLC image Pass 1
load ('../datasets/radar_bandel_hh2')                           	% L-band Radar SLC image Pass 2 

% Choose on channel for multi channel images: 
Iradar=Iradar(:,:,1); % RADAR P-Band : Get the first channel (HH-VV)
Ioptique=Ioptique(:,:,2); % OPTIQUE : Get the second channel (Green channel)

%  Convert into single image for resampling 
Iradar=single(Iradar);
Ioptique=single(Ioptique);
Ilidar=single(Ilidar);

warning('off')
%% -------- LIDAR over Radar  ---------------------------------------------
% Define the parameter


para = struct('radius' , 32:-4:8, ...
        'levels' , 6, ...
        'iter' , 2, ...
        'contrast_adapt', false, ...
        'rank', 4);

% Compute the flow    
W_lidar_radar=GeFolki(Iradar,Ilidar,para);

% Resample the image 
Ilidar_resampled=Gefolki_interpflow(Iradar,Ilidar,W_lidar_radar);


%% -------- Optics over Radar  --------------------------------------------
para = struct('radius' , 32:-4:8, ...
        'levels' , 6, ...
        'iter' , 2, ...
        'contrast_adapt', true, ...
        'rank', 4);
W_optique_radar=GeFolki(Iradar,Ioptique,para);
Ioptique_resampled=Gefolki_interpflow(Iradar,Ioptique,W_optique_radar);

toc;
