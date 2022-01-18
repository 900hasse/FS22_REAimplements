--
-- REA Script
-- author: 900Hasse
-- date: 23.11.2022
--
-- V1.0.0.0
--
-----------------------------------------
-- TO DO
---------------
-- 
-- 



-----------------------------------------
-- KNOWN ISSUES
---------------
-- 
-- 

print("---------------------------")
print("----- REA by 900Hasse -----")
print("---------------------------")
REAimplements = {};

function REAimplements.prerequisitesPresent(specializations)
    return true
end;

function REAimplements:loadMap(name)
end

function REAimplements:deleteMap()
end


function REAimplements:update(dt)

	if g_server ~= nil then
		-----------------------------------------------------------------------------------
		-- Global settings
		-----------------------------------------------------------------------------------
		-- Save global values
		if REAimplements.GlobalValuesSet ~= true then
			-----------------------------------------------------------------------------------
			-- Constants for force positions
			-----------------------------------------------------------------------------------
			REAimplements.LeftFront = 1;
			REAimplements.LeftRear = 2;
			REAimplements.RightFront = 3;
			REAimplements.RightRear = 4;

			-----------------------------------------------------------------------------------
			-- Settings for implement and terrain values
			-----------------------------------------------------------------------------------
			-- Tooltypes and names
			REAimplements.NoTool = 0;
			REAimplements.Plow = 1;
			REAimplements.Cultivator = 2;
			REAimplements.Roller = 3;
			REAimplements.SowingMachine = 4;
			REAimplements.Combine = 5;
			REAimplements.ForageWagon = 6;
			REAimplements.Baler = 7;
			REAimplements.Mulcher = 8;

			REAimplements.ToolTypeNames = {};
			REAimplements.ToolTypeNames[REAimplements.NoTool] = "No tool";
			REAimplements.ToolTypeNames[REAimplements.Plow] = "Plow";
			REAimplements.ToolTypeNames[REAimplements.Cultivator] = "Cultivator";
			REAimplements.ToolTypeNames[REAimplements.Roller] = "Roller";
			REAimplements.ToolTypeNames[REAimplements.SowingMachine] = "Sowing machine";
			REAimplements.ToolTypeNames[REAimplements.Combine] = "Combine";
			REAimplements.ToolTypeNames[REAimplements.ForageWagon] = "Forage wagon";
			REAimplements.ToolTypeNames[REAimplements.Baler] = "Baler";
			REAimplements.ToolTypeNames[REAimplements.Mulcher] = "Mulcher";

			-- Force type
			REAimplements.ForceTypeNone = 99;
			REAimplements.ForceTypePull = 1;
			REAimplements.ForceTypePTO = 2;
			REAimplements.ForceTypeFillspeed = 3;

			-- Terrain values and names
			REAimplements.OffField = 0;
			REAimplements.StubbleTillage = 1;
			REAimplements.Cultivated = 2;
			REAimplements.Seedbed = 3;
			REAimplements.Plowed = 4;
			REAimplements.RolledSeedbed = 5;
			REAimplements.Sown = 6;
			REAimplements.DirectSown = 7;
			REAimplements.Planted = 8;
			REAimplements.Ridge = 9;
			REAimplements.RollerLines = 10;
			REAimplements.HarvestReady = 11;
			REAimplements.HarvesReadyOther = 12;
			REAimplements.Grass = 13;
			REAimplements.GrassCut = 14;
			REAimplements.NoTerrainValue = 99;

			REAimplements.TerrainNames = {};
			REAimplements.TerrainNames[REAimplements.OffField] = "OffField";
			REAimplements.TerrainNames[REAimplements.StubbleTillage] = "StubbleTillage";
			REAimplements.TerrainNames[REAimplements.Cultivated] = "Cultivated";
			REAimplements.TerrainNames[REAimplements.Seedbed] = "Seedbed";
			REAimplements.TerrainNames[REAimplements.Plowed] = "Plowed";
			REAimplements.TerrainNames[REAimplements.RolledSeedbed] = "RolledSeedbed";
			REAimplements.TerrainNames[REAimplements.Sown] = "Sown";
			REAimplements.TerrainNames[REAimplements.DirectSown] = "DirectSown";
			REAimplements.TerrainNames[REAimplements.Planted] = "Planted";
			REAimplements.TerrainNames[REAimplements.Ridge] = "Ridge";
			REAimplements.TerrainNames[REAimplements.RollerLines] = "RollerLines";
			REAimplements.TerrainNames[REAimplements.HarvestReady] = "HarvestReady";
			REAimplements.TerrainNames[REAimplements.HarvesReadyOther] = "HarvesReadyOther";
			REAimplements.TerrainNames[REAimplements.Grass] = "Grass";
			REAimplements.TerrainNames[REAimplements.GrassCut] = "GrassCut";
			REAimplements.TerrainNames[REAimplements.NoTerrainValue] = "NoTerrainValue";

			-- Pulling multiplier on different groundtypes
			REAimplements.ForceFactors = {};
			local ToolType = 0;

			print("---------------------------")
			print("REA implements force factors")
			-- Plow
			ToolType = REAimplements.Plow;
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.OffField,1.3);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.StubbleTillage,0.8);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Cultivated,0.7);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Seedbed,0.9);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Plowed,0.5);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.RolledSeedbed,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Sown,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.DirectSown,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Planted,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Ridge,0.75);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.RollerLines,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.HarvestReady,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.HarvesReadyOther,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Grass,1.2);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.GrassCut,1.0);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.NoTerrainValue,1.0);
			-- Cultivator
			ToolType = REAimplements.Cultivator;
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.OffField,2);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.StubbleTillage,0.8);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Cultivated,0.7);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Seedbed,0.9);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Plowed,0.5);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.RolledSeedbed,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Sown,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.DirectSown,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Planted,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Ridge,0.8);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.RollerLines,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.HarvestReady,1.1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.HarvesReadyOther,1.1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Grass,1.5);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.GrassCut,1.2);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.NoTerrainValue,1.0);
			-- Mulcher
			ToolType = REAimplements.Mulcher;
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.OffField,2);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.StubbleTillage,0.8);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Cultivated,0.7);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Seedbed,0.9);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Plowed,0.5);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.RolledSeedbed,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Sown,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.DirectSown,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Planted,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Ridge,0.8);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.RollerLines,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.HarvestReady,1.1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.HarvesReadyOther,1.1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Grass,1.5);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.GrassCut,1.2);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.NoTerrainValue,1.0);
			-- Roller
			ToolType = REAimplements.Roller;
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.OffField,0.7);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.StubbleTillage,1.0);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Cultivated,1.0);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Seedbed,1.0);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Plowed,1.5);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.RolledSeedbed,0.8);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Sown,0.9);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.DirectSown,0.9);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Planted,0.9);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Ridge,1.3);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.RollerLines,0.9);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.HarvestReady,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.HarvesReadyOther,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Grass,0.9);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.GrassCut,0.8);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.NoTerrainValue,1.0);
			-- Sowing machine
			ToolType = REAimplements.SowingMachine;
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.OffField,2.0);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.StubbleTillage,1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Cultivated,0.8);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Seedbed,0.9);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Plowed,0.7);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.RolledSeedbed,0.8);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Sown,1.1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.DirectSown,1.1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Planted,1.1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Ridge,0.9);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.RollerLines,1.1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.HarvestReady,1.1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.HarvesReadyOther,1.1);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.Grass,1.25);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.GrassCut,1.15);
			REAimplements:AddForceFactor(REAimplements.ForceFactors,ToolType,REAimplements.NoTerrainValue,1.0);
			print("REA implements power need for filling 100l/s with a mass of 1000kg/m2")
			-- Power needed for balers and foragewagons to fill 100l/s for filltype with a mass of 1 ton/m2
			REAimplements.FillspeedPowerNeed = {};
			REAimplements.FillspeedPowerNeed[REAimplements.Combine] = 650;
			REAimplements.FillspeedPowerNeed[REAimplements.ForageWagon] = 500;
			REAimplements.FillspeedPowerNeed[REAimplements.Baler] = 450;
			print("Harvesters " .. REAimplements.FillspeedPowerNeed[REAimplements.Combine] .. "hp");
			print("Forage wagon " .. REAimplements.FillspeedPowerNeed[REAimplements.ForageWagon] .. "hp");
			print("Balers " .. REAimplements.FillspeedPowerNeed[REAimplements.Baler] .. "hp");
			print("---------------------------")
			-- Global values set
			REAimplements.GlobalValuesSet = true
		end;

		-----------------------------------------------------------------------------------
		-- Add REA functionality
		-----------------------------------------------------------------------------------
		-- Get number of vehicles
		local numVehicles = table.getn(g_currentMission.vehicles);
		-- If vehicles present run code
		if numVehicles ~= nil then
			-- Run code for vehicles
			if numVehicles >= 1 then
				for VehicleIndex=1, numVehicles do
					-- Save "vehicle" to local
					local vehicle = g_currentMission.vehicles[VehicleIndex];			
					-- Check if current vehicle exists
					if vehicle ~= nil then
						-- If vehicle is motorized save speed to use for shifting gear
						if vehicle.spec_motorized ~= nil then
							if vehicle.spec_motorized.motor ~= nil then
								-- Adjust speed of vehicle if PTO demands more power than motor can deliver
								if vehicle.spec_motorized.isMotorStarted then
									-- Adjust speed if PTO tourqe reaches high levels
									REAimplements:AdjustSpeedIfPtpPowerMaxed(vehicle,dt);
								end;
							end;
						end;
						-- Set tooltype
						if vehicle.ToolType == nil then
							REAimplements:SetToolType(vehicle);
						end;
						-- Tooltype found
						if vehicle.ToolType ~= REAimplements.NoTool then
							-- Adjust power need and speed of power consuming vehicle
							REAimplements:UpdatePowerMultiplier(vehicle,dt);
						end;
					end;
				end;
			end;
		end;
	end;
end;


-----------------------------------------------------------------------------------	
-- Add forcefactor to forcefactor table
-----------------------------------------------------------------------------------
function REAimplements:AddForceFactor(ForceFactorTable,ToolType,GroundType,Factor)
	-- Add tool to table
	if ForceFactorTable[ToolType] == nil then
		ForceFactorTable[ToolType] = {};
		ForceFactorTable[ToolType].Factor = {};
	end;
	-- Add groundtype to tool
	if ForceFactorTable[ToolType].Factor[GroundType] == nil then
		ForceFactorTable[ToolType].Factor[GroundType] = Factor;
	end;
	-- Print factor
	print(REAimplements.ToolTypeNames[ToolType] .. " on " .. REAimplements.TerrainNames[GroundType] .. " is " .. Factor);
end


-----------------------------------------------------------------------------------	
-- Set tooltype of implement
-----------------------------------------------------------------------------------
function REAimplements:SetToolType(vehicle)
	if vehicle.spec_powerConsumer ~= nil then
		local ToolForceType = "";
		local ToolForceTypePull = "Pull type";
		local ToolForceTypePTO = "PTO type";
		local ToolForceTypeFillspeed = "Fillspeed type";

		-- Check if there is a work area
		if vehicle.spec_workArea ~= nil then
			-- Plow
			if vehicle.spec_plow ~= nil then
				vehicle.ToolType = REAimplements.Plow;
				vehicle.ForceType = REAimplements.ForceTypePull;
				ToolForceType = ToolForceTypePull;
			-- Cultivator
			elseif vehicle.spec_cultivator ~= nil then
				vehicle.ToolType = REAimplements.Cultivator;
				vehicle.ForceType = REAimplements.ForceTypePull;
				ToolForceType = ToolForceTypePull;
			-- Roller
			elseif vehicle.spec_roller ~= nil then
				vehicle.ToolType = REAimplements.Roller;
				vehicle.ForceType = REAimplements.ForceTypePull;
				ToolForceType = ToolForceTypePull;
			-- Sowing machine
			elseif vehicle.spec_sowingMachine ~= nil then
				vehicle.ToolType = REAimplements.SowingMachine;
				vehicle.ForceType = REAimplements.ForceTypePull;
				ToolForceType = ToolForceTypePull;
			-- Mulcher
			elseif vehicle.spec_mulcher ~= nil and false then
				vehicle.ToolType = REAimplements.Mulcher;
				vehicle.ForceType = REAimplements.ForceTypePTO;
				ToolForceType = ToolForceTypePTO;
			end;
		end;
		-- Combine
		if vehicle.spec_combine ~= nil then
			vehicle.ToolType = REAimplements.Combine;
			vehicle.ForceType = REAimplements.ForceTypeFillspeed;
			ToolForceType = ToolForceTypeFillspeed;
		-- Forage wagon
		elseif vehicle.spec_forageWagon ~= nil then
			vehicle.ToolType = REAimplements.ForageWagon;
			vehicle.ForceType = REAimplements.ForceTypeFillspeed;
			ToolForceType = ToolForceTypeFillspeed;
		-- Baler
		elseif vehicle.spec_baler ~= nil then
			vehicle.ToolType = REAimplements.Baler;
			vehicle.ForceType = REAimplements.ForceTypeFillspeed;
			ToolForceType = ToolForceTypeFillspeed;
		end;
		-- If no tooltype found set no tool found
		if vehicle.ToolType == nil then
			vehicle.ToolType = REAimplements.NoTool;
			vehicle.ForceType = REAimplements.ForceTypeNone;
			ToolForceType = "not applied";
		end;
		--Print info
		print("----------------------")
		print("REA implements detected " .. vehicle:getFullName() .. " as a " .. REAimplements.ToolTypeNames[vehicle.ToolType] .. ", power need " .. ToolForceType)
	end;
end


-----------------------------------------------------------------------------------	
-- Function to calculate filling speed in thousend liters per second
-----------------------------------------------------------------------------------
function REAimplements:CalcFillSpeed(LastFillLevel,NewFillLevel,dt)
	-- Initialize liters per second
	local ThousendLiterPerSecond  = 0;
	-- If Fill level changed calculate fill speed
	if NewFillLevel > LastFillLevel then
		-- Calculate fill speed
		ThousendLiterPerSecond = ((NewFillLevel - LastFillLevel) / 1000) / (dt / 1000);
	end;
	-- Return last fill level and liter per seconds
	return NewFillLevel, ThousendLiterPerSecond;
end


-----------------------------------------------------------------------------------	
-- Function for adjusting speed if PTO tourqe reaches max motor tourqe
-----------------------------------------------------------------------------------
function REAimplements:AdjustSpeedIfPtpPowerMaxed(vehicle,dt)
	local motor = vehicle.spec_motorized.motor;

	-- Calculate avalible power
	local PowerAvalible = motor.motorAvailableTorque * motor.lastMotorRpm *math.pi/30
	-- Lowest speed setpoint
	local LowSpeedSetpoint = 3;
	-- Get speedlimit of motor
	local SpeedLimit = 1000;
	if motor.speedLimit ~= nil then
		if motor.speedLimit < SpeedLimit then
			SpeedLimit = motor.speedLimit;
		end;
	end;
	-- Get total power need by filling from all implements
	local TotalPowerNeedByFilling = 0;
	local HighestPowerNeed = 0;
	local attachedImplements;
	if vehicle.getAttachedImplements ~= nil then
		attachedImplements = vehicle:getAttachedImplements();
		for _, implement in pairs(attachedImplements) do
			if implement.object ~= nil then
				if implement.object.spec_powerConsumer ~= nil then
					-- Save to local power consumer
					local PowerConsumer = implement.object.spec_powerConsumer;
					-- If power is consumed by implement add power to total amount consumed by all implements
					if PowerConsumer.PowerToAddPTOSmoothed ~= nil then
						-- Initialize original speed limit of implement
						if PowerConsumer.OriginalSpeedlimit == nil then
							PowerConsumer.OriginalSpeedlimit = implement.object.speedLimit;
							PowerConsumer.CurrentSpeedLimit = PowerConsumer.OriginalSpeedlimit;
							PowerConsumer.SpeedRegulatorTimer = 0;
						end;
						-- Speedlimit of implement
						if implement.object:doCheckSpeedLimit() then
							-- Power consumed by filling
							TotalPowerNeedByFilling = PowerConsumer.PowerToAddPTOSmoothed + TotalPowerNeedByFilling;
							-- Save highest power need and speedlimit to know which implemnt to use as speedlimiter
							if PowerConsumer.PowerToAddPTOSmoothed > HighestPowerNeed then
								HighestPowerNeed = PowerConsumer.PowerToAddPTOSmoothed;
								SpeedLimit = PowerConsumer.OriginalSpeedlimit;
							end;
						end;
					end;
				end;
			end;
		end;
		-- Adjust speed depending on power need
		for _, implement in pairs(attachedImplements) do
			if implement.object ~= nil then
				if implement.object.spec_powerConsumer ~= nil then
					-- Save to local power consumer
					local PowerConsumer = implement.object.spec_powerConsumer;
					if PowerConsumer.PowerToAddPTOSmoothed ~= nil then
						-- If implement uses power from filling check if power needed and is the most consuming adjust speedlimit
						if PowerConsumer.PowerToAddPTOSmoothed == HighestPowerNeed and HighestPowerNeed ~= 0 then
							-- Regulator for adjusting speed depending on poweruse by filling
							PowerConsumer.CurrentSpeedLimit,PowerConsumer.SpeedRegulatorTimer = REAimplements:SpeedPowerRegulator(TotalPowerNeedByFilling,PowerAvalible*0.9,LowSpeedSetpoint,SpeedLimit,PowerConsumer.CurrentSpeedLimit,PowerConsumer.SpeedRegulatorTimer,dt);
							-- Add speed limit to implement
							implement.object.speedLimit = PowerConsumer.CurrentSpeedLimit;
						-- Implement is not the one consuming the most set original speedlimt
						else
							implement.object.speedLimit = PowerConsumer.OriginalSpeedlimit;
						end;
					end;
				end;
			end;
		end;
	end;
end;


-----------------------------------------------------------------------------------	
-- Update power multiplier for power consumers
-----------------------------------------------------------------------------------
function REAimplements:UpdatePowerMultiplier(vehicle,dt)
	if vehicle.ForceType == REAimplements.ForceTypePull then
		-- Adjust force for implements that is affected by ground
		REAimplements:UpdateForcePulltype(vehicle,dt);
	elseif vehicle.ForceType == REAimplements.ForceTypePTO then
		-- Adjust force for implements that is affected by ground
		REAimplements:UpdatePowerGroundtype(vehicle,dt);
	elseif vehicle.ForceType == REAimplements.ForceTypeFillspeed and vehicle.spec_fillUnit ~= nil then
		-- Adjust power and speed for implements that is affected by PTO
		REAimplements:UpdatePowerFillspeed(vehicle,dt)
	end;
end


-----------------------------------------------------------------------------------	
-- Function to round value, delete decimals
-----------------------------------------------------------------------------------
function REAimplements:RoundValue(x)
	return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end


-----------------------------------------------------------------------------------	
-- Function to updater force for pull type implements
-----------------------------------------------------------------------------------
function REAimplements:UpdateForcePulltype(vehicle,dt)
	local PowerConsumer = vehicle.spec_powerConsumer;
	if PowerConsumer.forceNode ~= nil then
		-- Save original max force and create node for gound type
		if PowerConsumer.ForcePosition == nil then
			-- Create force positions
			REAimplements:CreateForcePositions(vehicle,vehicle.ToolType,PowerConsumer,vehicle.spec_workArea.workAreas);
			-- Set initial speed and direction of force position nodes
			REAimplements:UpdateDirectionAndSpeed(PowerConsumer,dt)
			-- Variables for force to apply on right and left side
			PowerConsumer.MaxForceLeft = 0;
			PowerConsumer.MaxForceRight = 0;
		end;
		-- Calculate multiplier depending on type of implement and ground type
		local TargetMaxForceLeftSide = PowerConsumer.maxForce / 2;
		local TargetMaxForceRightSide = PowerConsumer.maxForce / 2;
		-- Determine which groundtype it is
		local DensityTypeName = REAimplements.TerrainNames[REAimplements.NoTerrainValue];
		local terrainValue = REAimplements.NoTerrainValue;
		if vehicle:doCheckSpeedLimit() then

			-- Update position of force positions
			REAimplements:UpdatePositionOfForcePositions(vehicle.ToolType,PowerConsumer,vehicle.spec_workArea.workAreas);
			-- Update groundtype nodes
			REAimplements:UpdateGroundTypeNodes(vehicle.ToolType,PowerConsumer,PowerConsumer.ForcePosition[REAimplements.LeftFront].GroundTypeRefNode,PowerConsumer.ForcePosition[REAimplements.RightFront].GroundTypeRefNode)
			-- Get speed and direction of force position nodes
			REAimplements:UpdateDirectionAndSpeed(PowerConsumer,dt)
			-- Get average forcefactor
			TargetMaxForceLeftSide,TargetMaxForceRightSide,DensityTypeName = REAimplements:GetForce(vehicle.ToolType,PowerConsumer.GroundTypeNodes,PowerConsumer.maxForce);

			-- DEBUG
			if REAimplements.Debug then
				local GroundTypeNumber = 0;
				for _, node in pairs(PowerConsumer.GroundTypeNodes) do
					local x , _ , _ = localToLocal(PowerConsumer.forceNode, node, 0,0,0);
					GroundTypeNumber = GroundTypeNumber + 1;
					DebugUtil.drawDebugNode(node,"G" .. REAimplements:RoundValue(x), false);
				end;
				DebugUtil.drawDebugNode(PowerConsumer.forceNode,"F", false);
				renderText(0.2, 0.10, 0.02,"Force left: " .. PowerConsumer.MaxForceLeft);
				renderText(0.2, 0.13, 0.02,"Force right: " .. PowerConsumer.MaxForceRight);
				renderText(0.2, 0.16, 0.02,"Max force: " .. PowerConsumer.maxForce);
				renderText(0.2, 0.19, 0.02,"Terrain value: " .. terrainValue);
				renderText(0.2, 0.22, 0.02,"Terrain name: " .. DensityTypeName);
				renderText(0.2, 0.25, 0.02,"Tool name: " .. REAimplements.ToolTypeNames[vehicle.ToolType]);
				renderText(0.2, 0.28, 0.02,"Left Speed F/S: " .. REAimplements:RoundValueTwoDecimals(PowerConsumer.ForcePosition[REAimplements.LeftFront].ForwardSpeedSigned) .. " / " .. REAimplements:RoundValueTwoDecimals(PowerConsumer.ForcePosition[REAimplements.LeftFront].SidewaySpeedSigned));
				renderText(0.2, 0.31, 0.02,"Right Speed F/S: " .. REAimplements:RoundValueTwoDecimals(PowerConsumer.ForcePosition[REAimplements.RightFront].ForwardSpeedSigned) .. " / " .. REAimplements:RoundValueTwoDecimals(PowerConsumer.ForcePosition[REAimplements.RightFront].SidewaySpeedSigned));
			end;

		end;
		-- Save new values
		PowerConsumer.MaxForceLeft = REAimplements:SmootheValue(PowerConsumer.MaxForceLeft,TargetMaxForceLeftSide);
		PowerConsumer.MaxForceRight = REAimplements:SmootheValue(PowerConsumer.MaxForceRight,TargetMaxForceRightSide);
	end;
end


-----------------------------------------------------------------------------------	
-- Function to calculate speed and direction based on movement
-----------------------------------------------------------------------------------
function REAimplements:UpdateDirectionAndSpeed(PowerConsumer,dt)
	-- Get speed and direction of force position nodes
	for _, ForcePosition in pairs(PowerConsumer.ForcePosition) do
		REAimplements:GetDirectionAndSpeed(ForcePosition,dt)
	end;
end;


-----------------------------------------------------------------------------------	
-- Function to set is left node
-----------------------------------------------------------------------------------
function REAimplements:SetIsLeft(PowerConsumer,ForcePositionIndex)
	if PowerConsumer.NumberOfLeft == nil then
		PowerConsumer.NumberOfLeft = 0;
	end;
	PowerConsumer.ForcePosition[ForcePositionIndex].IsLeft = true;
	PowerConsumer.ForcePosition[ForcePositionIndex].IsRight = false;
	PowerConsumer.NumberOfLeft = PowerConsumer.NumberOfLeft + 1;
end;


-----------------------------------------------------------------------------------	
-- Function to set is left node
-----------------------------------------------------------------------------------
function REAimplements:SetIsRight(PowerConsumer,ForcePositionIndex)
	if PowerConsumer.NumberOfRight == nil then
		PowerConsumer.NumberOfRight = 0;
	end;
	PowerConsumer.ForcePosition[ForcePositionIndex].IsLeft = false;
	PowerConsumer.ForcePosition[ForcePositionIndex].IsRight = true;
	PowerConsumer.NumberOfRight = PowerConsumer.NumberOfRight + 1;
end;


-----------------------------------------------------------------------------------	
-- Function to create force positions
-----------------------------------------------------------------------------------
function REAimplements:CreateForcePositions(Vehicle,ToolType,PowerConsumer,WorkAreas)
	-- Create force position table
	PowerConsumer.ForcePosition = {};
	local ParentNode = PowerConsumer.forceNode; 
	-- Create Force nodes
	if ToolType == REAimplements.Plow then		
		local numWorkArea = table.getn(WorkAreas);
		if numWorkArea > 1 then
			-- Not nice... Only to get plows with two workareas to work :(
			local HasTwoPlowareas = WorkAreas[2].type == WorkAreaType.PLOW;
			if HasTwoPlowareas then
				if Vehicle.spec_wheels ~= nil then
					if Vehicle.spec_wheels.wheels ~= nil then 
						if table.getn(Vehicle.spec_wheels.wheels) > 1 then
							local LargestRadius = 0;
							local ActWheel;
							for _,wheel in pairs(Vehicle.spec_wheels.wheels) do
								if wheel.radiusOriginal > LargestRadius then							
									ActWheel = wheel;
									LargestRadius = wheel.radiusOriginal;
								end;
							end;
							-- Create parent for force positipn nodes
							local ForceParent = createTransformGroup("ForceParent")
							link(ActWheel.repr, ForceParent);
							setTranslation(ForceParent,0,0,0);
							setRotation(ForceParent,0,0,0);
							setScale(ForceParent,1,1,1);
							ParentNode = ForceParent;
							print("REA implements: " .. Vehicle:getFullName() .. " as a " .. REAimplements.ToolTypeNames[Vehicle.ToolType] .. " uses wheel as a reference")
						end;
					end;
				end;
			end;
		end;

		PowerConsumer.ForcePosition[REAimplements.LeftFront] = {};
		PowerConsumer.ForcePosition[REAimplements.LeftFront].Node = REAimplements:CreateNode(ParentNode,0,0,0,"ForcePositionLeftFrontNode");
		PowerConsumer.ForcePosition[REAimplements.LeftFront].GroundTypeRefNode = REAimplements:CreateNode(ParentNode,0,0,0,"GroundPositionLeftFrontNode");
		REAimplements:SetIsLeft(PowerConsumer,REAimplements.LeftFront);

		PowerConsumer.ForcePosition[REAimplements.LeftRear] = {};
		PowerConsumer.ForcePosition[REAimplements.LeftRear].Node = REAimplements:CreateNode(ParentNode,0,0,0,"ForcePositionLeftRearNode");
		REAimplements:SetIsLeft(PowerConsumer,REAimplements.LeftRear);

		PowerConsumer.ForcePosition[REAimplements.RightFront] = {};
		PowerConsumer.ForcePosition[REAimplements.RightFront].Node = REAimplements:CreateNode(ParentNode,0,0,0,"ForcePositionRightFrontNode");
		PowerConsumer.ForcePosition[REAimplements.RightFront].GroundTypeRefNode = REAimplements:CreateNode(ParentNode,0,0,0,"GroundPositionLeftFrontNode");
		REAimplements:SetIsRight(PowerConsumer,REAimplements.RightFront);

		PowerConsumer.ForcePosition[REAimplements.RightRear] = {};
		PowerConsumer.ForcePosition[REAimplements.RightRear].Node = REAimplements:CreateNode(ParentNode,0,0,0,"ForcePositionRightRearNode");
		REAimplements:SetIsRight(PowerConsumer,REAimplements.RightRear);

	else

		PowerConsumer.ForcePosition[REAimplements.LeftFront] = {};
		PowerConsumer.ForcePosition[REAimplements.LeftFront].Node = REAimplements:CreateNode(ParentNode,0,0,0,"ForcePositionLeftFrontNode");
		PowerConsumer.ForcePosition[REAimplements.LeftFront].GroundTypeRefNode = REAimplements:CreateNode(ParentNode,0,0,0,"GroundPositionLeftFrontNode");
		REAimplements:SetIsLeft(PowerConsumer,REAimplements.LeftFront);

		PowerConsumer.ForcePosition[REAimplements.LeftRear] = {};
		PowerConsumer.ForcePosition[REAimplements.LeftRear].Node = REAimplements:CreateNode(ParentNode,0,0,0,"ForcePositionLeftRearNode");
		REAimplements:SetIsLeft(PowerConsumer,REAimplements.LeftRear);

		PowerConsumer.ForcePosition[REAimplements.RightFront] = {};
		PowerConsumer.ForcePosition[REAimplements.RightFront].Node = REAimplements:CreateNode(ParentNode,0,0,0,"ForcePositionRightFrontNode");
		PowerConsumer.ForcePosition[REAimplements.RightFront].GroundTypeRefNode = REAimplements:CreateNode(ParentNode,0,0,0,"GroundPositionLeftFrontNode");
		REAimplements:SetIsRight(PowerConsumer,REAimplements.RightFront);

		PowerConsumer.ForcePosition[REAimplements.RightRear] = {};
		PowerConsumer.ForcePosition[REAimplements.RightRear].Node = REAimplements:CreateNode(ParentNode,0,0,0,"ForcePositionRightRearNode");
		REAimplements:SetIsRight(PowerConsumer,REAimplements.RightRear);

	end;
	-- Save parent node
	PowerConsumer.ForcePositionNode = ParentNode;
end;


-----------------------------------------------------------------------------------	
-- Function to create force positions
-----------------------------------------------------------------------------------
function REAimplements:UpdatePositionOfForcePositions(ToolType,PowerConsumer,WorkAreas)
	local ParentNode = PowerConsumer.ForcePositionNode;
	local _,my,_ = getCenterOfMass(PowerConsumer.forceNode)
	if ToolType == REAimplements.Plow then
		local sX, sY, sZ = 0,0,0;
		local hX, hY, hZ = 0,0,0;
		local PlowDivider = 1;
		if PowerConsumer.ForcePositionNode ~= PowerConsumer.forceNode then
			sX, _, sZ = localToLocal(WorkAreas[1].start,ParentNode,0,0,0);
			wX, _, wZ = localToLocal(WorkAreas[1].width,ParentNode,0,0,0);
			hX, _, hZ = localToLocal(WorkAreas[2].height,ParentNode,0,0,0);
			PlowDivider = 2;
		else
			sX, _, sZ = localToLocal(WorkAreas[1].start,ParentNode,0,0,0);
			wX, _, wZ = localToLocal(WorkAreas[1].width,ParentNode,0,0,0);
			hX, _, hZ = localToLocal(WorkAreas[1].height,ParentNode,0,0,0);
		end;

		setTranslation(PowerConsumer.ForcePosition[REAimplements.LeftFront].GroundTypeRefNode,hX,my,hZ);
		setTranslation(PowerConsumer.ForcePosition[REAimplements.RightFront].GroundTypeRefNode,sX,my,sZ);
		setTranslation(PowerConsumer.ForcePosition[REAimplements.LeftFront].Node,hX/PlowDivider,my,wZ/PlowDivider);
		setTranslation(PowerConsumer.ForcePosition[REAimplements.LeftRear].Node,hX/PlowDivider,my,hZ/PlowDivider);
		setTranslation(PowerConsumer.ForcePosition[REAimplements.RightFront].Node,wX/PlowDivider,my,wZ/PlowDivider);
		setTranslation(PowerConsumer.ForcePosition[REAimplements.RightRear].Node,wX/PlowDivider,my,hZ/PlowDivider);

	else
		local sX, _, sZ = localToLocal(WorkAreas[1].start,ParentNode,0,0,0);
		local wX, _, wZ = localToLocal(WorkAreas[1].width,ParentNode,0,0,0);
		local hX, _, hZ = localToLocal(WorkAreas[1].height,ParentNode,0,0,0);
		setTranslation(PowerConsumer.ForcePosition[REAimplements.LeftFront].GroundTypeRefNode,sX,my,sZ);
		setTranslation(PowerConsumer.ForcePosition[REAimplements.RightFront].GroundTypeRefNode,wX,my,wZ);
		setTranslation(PowerConsumer.ForcePosition[REAimplements.LeftFront].Node,sX,my,sZ);
		setTranslation(PowerConsumer.ForcePosition[REAimplements.LeftRear].Node,hX,my,hZ);
		setTranslation(PowerConsumer.ForcePosition[REAimplements.RightFront].Node,wX,my,wZ);
		setTranslation(PowerConsumer.ForcePosition[REAimplements.RightRear].Node,wX,my,hZ);
	end;
end;


-----------------------------------------------------------------------------------	
-- Function to calculate speed and direction based on movement
-----------------------------------------------------------------------------------
function REAimplements:AlignToWorld(PowerConsumer,ForcePositions)
	local x1,y1,z1 = getWorldTranslation(self.nodeId)
	y1 = getTerrainHeightAtWorldPos(g_currentMission.terrainRootNode, x1,y1,z1)
	setTranslation(self.nodeId, x1,y1,z1)
	local x2,y2,z2 = getWorldTranslation(ForcePositions[1].node)
	y2 = getTerrainHeightAtWorldPos(g_currentMission.terrainRootNode, x2,y2,z2)
	local x3,y3,z3 = getWorldTranslation(ForcePositions[2].node)
	y3 = getTerrainHeightAtWorldPos(g_currentMission.terrainRootNode, x3,y3,z3)
	local x4,y4,z4 = getWorldTranslation(ForcePositions[3].node)
	y4 = getTerrainHeightAtWorldPos(g_currentMission.terrainRootNode, x4,y4,z4)
	local dirX = x2 - x1
	local dirY = y2 - y1
	local dirZ = z2 - z1
	local dir2X = x3 - x4
	local dir2Y = y3 - y4
	local dir2Z = z3 - z4
	local upX,upY,upZ = MathUtil.crossProduct(dir2X, dir2Y, dir2Z, dirX, dirY, dirZ)
	setDirection(self.nodeId, dirX, dirY, dirZ, upX,upY,upZ)
end

-----------------------------------------------------------------------------------	
-- Function to calculate speed and direction based on movement
-----------------------------------------------------------------------------------
function REAimplements:GetDirectionAndSpeed(ForcePosition,dt)
	-- Calculate speed based on the position change
	if ForcePosition.LastPosition == nil then
		local x,y,z = getWorldTranslation(ForcePosition.Node);
		ForcePosition.LastPosition = {};
		ForcePosition.LastPosition[1] = x;
		ForcePosition.LastPosition[2] = y;
		ForcePosition.LastPosition[3] = z;
		ForcePosition.ForwardSpeedSigned = 0;
		ForcePosition.SidewaySpeedSigned = 0;
	end;
	-- Calculate speed and direction
	local SpeedDiffX, _, SpeedDiffZ = REAimplements:CalcPositionDifferance(ForcePosition.Node,ForcePosition.LastPosition);
	ForcePosition.ForwardSpeed, ForcePosition.ForwardSpeedSigned, ForcePosition.ForwardDirection = REAimplements:CalcSpeedAndDirection(ForcePosition.ForwardSpeedSigned,SpeedDiffZ,dt)
	ForcePosition.SidewaySpeed, ForcePosition.SidewaySpeedSigned, ForcePosition.SidewayDirection = REAimplements:CalcSpeedAndDirection(ForcePosition.SidewaySpeedSigned,SpeedDiffX,dt)
end;


-----------------------------------------------------------------------------------	
-- Get position differance of node
-----------------------------------------------------------------------------------
function REAimplements:CalcPositionDifferance(Node,LastPosition)
	local x,y,z = getWorldTranslation(Node);
	local DiffX, DiffY, DiffZ = worldDirectionToLocal(Node, x-LastPosition[1], y-LastPosition[2], z-LastPosition[3]);
	-- Save values for next evaluation
	LastPosition[1] = x;
	LastPosition[2] = y;
	LastPosition[3] = z;
	-- Return result
	return DiffX, DiffY, DiffZ;
end


-----------------------------------------------------------------------------------	
-- Function to calculate speed and direcrtion based on movement
-----------------------------------------------------------------------------------
function REAimplements:CalcSpeedAndDirection(LastSpeedSigned,MovedDistance,dt)
	-- Calculate speed of wheel
	local SpeedSigned = (MovedDistance / dt)*3600;
	local SpeedSignedSmoothe = REAimplements:SmootheValue(LastSpeedSigned,SpeedSigned)
	local Speed = SpeedSignedSmoothe;
	-- Remove sign
	if Speed < 0 then
		Speed = Speed*(-1); 
	end;
	-- Moving direction
	local MovingDirection = 0;
	if SpeedSigned > 0.01 then
		MovingDirection = 1;
	elseif SpeedSigned < -0.01 then
		MovingDirection = -1;
	end;
	-- Return result
	return Speed, SpeedSignedSmoothe, MovingDirection;
end


-----------------------------------------------------------------------------------	
-- Function to updater power for PTO type implements
-----------------------------------------------------------------------------------
function REAimplements:UpdatePowerGroundtype(vehicle,dt)
	-- Nothing yet
end


-----------------------------------------------------------------------------------	
-- Function to updater power for fillspeed implements
-----------------------------------------------------------------------------------
function REAimplements:UpdatePowerFillspeed(vehicle,dt)
	-- Save local copy of FillUnit
	local FillUnit = vehicle.spec_fillUnit;
	-- Get number of fillunits
	local numFillUnits = table.getn(FillUnit.fillUnits);
	-- Total fill level for all fillunits
	local TotalFillLevel = 0;
	-- Highest fillspeed
	local HighestFillLevel = 0;
	-- Mass of filltype in Ton/m2
	local HighestFillLevelMassTM2 = 1;
	-- Create variables for calculating fill speed
	if FillUnit.TimeLastChange == nil then
		FillUnit.TimeLastChange = 0;
		FillUnit.LastTotalFillLevel = 0;
		FillUnit.AddedFillLevel = 0;
		FillUnit.FillSpeedLS = 0;
		FillUnit.FillSpeedLSSmoothed = 0;
	end;
	-- Add time change since last fill, max 1 second
	if FillUnit.TimeLastChange < 1000 then
		FillUnit.TimeLastChange = FillUnit.TimeLastChange + dt;
	end;
	-- Search for correct fill unit and get current filllevel
	for FillUnitIndex=1, numFillUnits do
		local ActFillUnit = FillUnit.fillUnits[FillUnitIndex];
		if ActFillUnit.fillType ~= FillType.DIESEL and ActFillUnit.fillType ~= FillType.DEF then
			-- Calculate total fill speed
			TotalFillLevel = TotalFillLevel + ActFillUnit.fillLevel;
			-- Get mass of filltype from the fillunit with highest fillspeed, Ton/m2
			if ActFillUnit.fillLevel > HighestFillLevel then
				HighestFillLevel = ActFillUnit.fillLevel;
				HighestFillLevelMassTM2 = g_currentMission.fillTypeManager.fillTypes[ActFillUnit.fillType].massPerLiter * 1000;
			end;
		end;
	end;
	-- Calculate change in fill level
	FillUnit.AddedFillLevel = TotalFillLevel - FillUnit.LastTotalFillLevel;
	-- Save fill level
	FillUnit.LastTotalFillLevel = TotalFillLevel;
	-- If fillunit added fill since last update calculate fillspeed and reset value
	FillUnit.FillSpeedLS = 0;
	if FillUnit.AddedFillLevel > 0 then
		-- Calculate fillspeed Liter / second
		FillUnit.FillSpeedLS = FillUnit.AddedFillLevel / (FillUnit.TimeLastChange / 1000);
		FillUnit.TimeLastChange = 0;
		FillUnit.AddedFillLevel = 0;
	end;
	-- Smoothe fillspeed value
	FillUnit.FillSpeedLSSmoothed = REAimplements:SmootheValue(FillUnit.FillSpeedLSSmoothed,FillUnit.FillSpeedLS);
	if FillUnit.FillSpeedLSSmoothed < 0.001 then
		FillUnit.FillSpeedLSSmoothed = 0;
	end;

	-- If combine use cutter as power consumer
	local CutterWorking = false;
	local PowerConsumer;
	if vehicle.ToolType == REAimplements.Combine then
		if vehicle.spec_combine.attachedCutters ~= nil then
			local cutters = vehicle.spec_combine.attachedCutters;
			for cutter, _ in pairs(cutters) do
				if cutter:doCheckSpeedLimit() and cutter.spec_powerConsumer ~= nil then
					PowerConsumer = cutter.spec_powerConsumer;
					CutterWorking = true;
				end;
			end;
		end;
	elseif vehicle.spec_powerConsumer ~= nil then
		PowerConsumer = vehicle.spec_powerConsumer;
	end;
	-- If vehicle is working add fillspeed power need
	if PowerConsumer ~= nil then
		-- Initiate variables
		if PowerConsumer.PowerToAddPTOSmoothed == nil then
			PowerConsumer.PowerToAddPTOSmoothed = 0;
		end;
		-- Save original values with a lowered non working power need
		if PowerConsumer.OriginalNeededMinPtoPower == nil and PowerConsumer.neededMinPtoPower ~= nil then
			PowerConsumer.OriginalNeededMinPtoPower = PowerConsumer.neededMinPtoPower;
		end;
		if PowerConsumer.OriginalNeededMaxPtoPower == nil and PowerConsumer.neededMaxPtoPower ~= nil then
			PowerConsumer.OriginalNeededMaxPtoPower = PowerConsumer.neededMaxPtoPower;
		end;
		-- Power need for machine without any material flow
		local PowerFactorForMachine = 0.4;
		local PowerNeedMachineMin = 0;
		local PowerNeedMachineMax = 0;
		if PowerConsumer.neededMinPtoPower ~= nil then
			PowerNeedMachineMin = PowerConsumer.OriginalNeededMinPtoPower * PowerFactorForMachine;
		end;
		if PowerConsumer.neededMaxPtoPower ~= nil then
			PowerNeedMachineMax = PowerConsumer.OriginalNeededMaxPtoPower * PowerFactorForMachine;
		end;
		-- Add power to PTO if vehicle is working
		if vehicle:doCheckSpeedLimit() or (vehicle.ToolType == REAimplements.Combine and CutterWorking) then
			local PowerToAddPTO = 0;
			-- If fillspeed present add power
			local MinPowerToAdd = 0.001;
			local FillspeedPowerNeed = 400;
			if FillUnit.FillSpeedLSSmoothed > 0.001 then
				-- Calculate power to be added to PTO based on filling speed
				if REAimplements.FillspeedPowerNeed[vehicle.ToolType] ~= nil then
					FillspeedPowerNeed = REAimplements.FillspeedPowerNeed[vehicle.ToolType];
				end;
				PowerToAddPTO = (FillspeedPowerNeed * (FillUnit.FillSpeedLSSmoothed/100)) * HighestFillLevelMassTM2;
			end;
			-- Smoothe power to add
			PowerConsumer.PowerToAddPTOSmoothed = math.max(MinPowerToAdd,REAimplements:SmootheValue(PowerConsumer.PowerToAddPTOSmoothed,PowerToAddPTO));
			-- Add power need
			if PowerConsumer.PowerToAddPTOSmoothed > MinPowerToAdd then
				if PowerConsumer.neededMinPtoPower ~= nil then
					PowerConsumer.neededMinPtoPower = PowerNeedMachineMin + PowerConsumer.PowerToAddPTOSmoothed;
				end;
				if PowerConsumer.neededMaxPtoPower ~= nil then
					PowerConsumer.neededMaxPtoPower = PowerNeedMachineMax + PowerConsumer.PowerToAddPTOSmoothed;
				end;
			end;

			-- DEBUG
			if REAimplements.Debug then
				renderText(0.2, 0.10, 0.02,"PTO Power to add: " .. tostring(PowerConsumer.PowerToAddPTOSmoothed));
				renderText(0.2, 0.13, 0.02,"Machine power need: " .. tostring(PowerNeedMachineMin));
				renderText(0.2, 0.16, 0.02,"Total power need: " .. tostring(PowerNeedMachineMin + PowerConsumer.PowerToAddPTOSmoothed));
				renderText(0.2, 0.19, 0.02,"Tool name: " .. REAimplements.ToolTypeNames[vehicle.ToolType]);
				renderText(0.2, 0.22, 0.02,"Fillspeed power need: " .. FillspeedPowerNeed);
			end;

		else
			-- No power needed
			PowerConsumer.PowerToAddPTOSmoothed = 0;
			-- Reset to original values
			if PowerConsumer.neededMinPtoPower ~= nil then
				PowerConsumer.neededMinPtoPower = PowerNeedMachineMin;
			end;
			if PowerConsumer.neededMaxPtoPower ~= nil then
				PowerConsumer.neededMaxPtoPower = PowerNeedMachineMax;
			end;
		end;
	end;
end


-----------------------------------------------------------------------------------	
-- Function to get distance betweene two nodes
-----------------------------------------------------------------------------------
function REAimplements:GetDistance(Node1,Node2)
    local x1, y1, z1 = getWorldTranslation(Node1);
    local x2, y2, z2 = getWorldTranslation(Node2);
    return MathUtil.vector3Length(x1-x2, y1-y2, z1-z2);
end;


-----------------------------------------------------------------------------------	
-- Function to get force on the left and tight side
-----------------------------------------------------------------------------------
function REAimplements:GetForce(ToolType,GroundTypeNodes,MaxForce)
	local ForceLeftSide = 0;
	local ForceRightSide = 0;
	local NumberOfGroundTypeNodes = table.getn(GroundTypeNodes);
	local Distance = REAimplements:GetDistance(GroundTypeNodes[1],GroundTypeNodes[NumberOfGroundTypeNodes]);
	local LastTerrainName = "";
	for _, GroundTypeNode in pairs(GroundTypeNodes) do
		-- Get terrainvalue from node
		local terrainValue = REAimplements:GetTerrainValue(GroundTypeNode)
		-- Get distance to ForceNode
		local DistanceFactorLeft = (Distance - REAimplements:GetDistance(GroundTypeNode,GroundTypeNodes[1])) / Distance;
		local DistanceFactorRight = (Distance - REAimplements:GetDistance(GroundTypeNode,GroundTypeNodes[NumberOfGroundTypeNodes])) / Distance;
		-- Get forcefactor for tooltype and ground state
		local ForceFactor = 1
		if REAimplements.ForceFactors[ToolType].Factor[terrainValue] ~= nil then
			ForceFactor = REAimplements.ForceFactors[ToolType].Factor[terrainValue];
			LastTerrainName = REAimplements.TerrainNames[terrainValue];
		end;
		-- Force to add from current ground node
		local ForceToAdd = (MaxForce * ForceFactor) / NumberOfGroundTypeNodes;
		-- Divide force on left and right side and add to total force
		ForceLeftSide = ForceLeftSide + (ForceToAdd * DistanceFactorLeft);
		ForceRightSide = ForceRightSide + (ForceToAdd * DistanceFactorRight);
	end;
	return ForceLeftSide,ForceRightSide,LastTerrainName;
end


-----------------------------------------------------------------------------------	
-- Function to get power with multiplier
-----------------------------------------------------------------------------------
function REAimplements:GetPower(ToolType,GroundTypeNodes,OriginalForce)
	local LastTerrainName = "";
	local Power = 0;
	local NumberOfGroundTypeNodes = table.getn(GroundTypeNodes);
	for _, GroundTypeNode in pairs(GroundTypeNodes) do
		-- Get terrainvalue from node
		local terrainValue = REAimplements:GetTerrainValue(GroundTypeNode)
		-- Get forcefactor for tooltype and ground state
		local ForceFactor = 1
		if REAimplements.ForceFactors[ToolType].Factor[terrainValue] ~= nil then
			ForceFactor = REAimplements.ForceFactors[ToolType].Factor[terrainValue];
			LastTerrainName = REAimplements.TerrainNames[terrainValue];
		end;
		-- Force to add from current ground node
		Power = Power + (OriginalForce * ForceFactor);
	end;
	return Power / NumberOfGroundTypeNodes,LastTerrainName;
end


-----------------------------------------------------------------------------------	
-- Function to get terrain value from node
-----------------------------------------------------------------------------------
function REAimplements:GetTerrainValue(node)
	local wx, wy, wz = getWorldTranslation(node);
	local GroundTypeMapId, groundTypeFirstChannel, groundTypeNumChannels = g_currentMission.fieldGroundSystem:getDensityMapData(FieldDensityMap.GROUND_TYPE);
	local DensityBits = getDensityAtWorldPos(GroundTypeMapId, wx, wy, wz);
	return bitAND(bitShiftRight(DensityBits, groundTypeFirstChannel), 2^groundTypeNumChannels - 1);
end


-----------------------------------------------------------------------------------	
-- Function to create node
-----------------------------------------------------------------------------------
function REAimplements:CreateNode(ParentNode,x,y,z,Name)
	-- Create groundtype node
	local Node = createTransformGroup(Name)
	link(ParentNode, Node);
	setTranslation(Node,x,y,z);
	setRotation(Node,0,0,0);
	setScale(Node, 1, 1, 1);
	return Node;
end


-----------------------------------------------------------------------------------	
-- Function to create ground type nodes
-----------------------------------------------------------------------------------
function REAimplements:UpdateGroundTypeNodes(ToolType,PowerConsumer,LeftNode,RightNode)
	-- Get workarea
	local x,y,z = localToLocal(LeftNode,RightNode,0,0,0);
	-- Total distance of workarea
	local Distance = REAimplements:GetDistance(LeftNode,RightNode);
	-- Creat position in front of workarea
	local OffsetInFront = 0;
	local PlowOffset = 0;
	local PlowOffsetDir = 0;
	-- Actual distance betweene each groundtype node
	local DistanceBetweeneEachNode = 0;
	-- Number of nodes to create
	local NumGroundType = 0;
	-- Each step for each node
	local StepX = 0;
	local StepY = 0;
	local StepZ = 0;
	local Dir = -1;
	if ToolType == REAimplements.Plow then
		-- Expected distance betweene each groundtype node
		local DistanceEachNode = 0.8;
		-- Number of groundtype nodes to use
		local MinNumberNodes = 3;
		local MaxNumberNodes = 15;
		-- Get number of nodes and distance betweene them
		NumGroundType,DistanceBetweeneEachNode = REAimplements:GetNumberOfGroundTypeNodes(Distance,DistanceEachNode,MinNumberNodes,MaxNumberNodes);
		OffsetInFront = 0.7;
		PlowOffset = 0.7;
		-- Determin direction of plow offset
		local PlowX,_,_ = localToLocal(LeftNode,PowerConsumer.forceNode,0,0,0);
		if PlowX >= 0 then
			PlowOffsetDir = 1;
		else
			PlowOffsetDir = -1;
		end;
		-- Each step for each node
		StepX = (x / (NumGroundType-1)) * Dir;
		StepY = (y / (NumGroundType-1)) * Dir;
		StepZ = (z / (NumGroundType-1)) * Dir;
	else
		-- Expected distance betweene each groundtype node
		local DistanceEachNode = 1.5;
		-- Number of groundtype nodes to use
		local MinNumberNodes = 4;
		local MaxNumberNodes = 8;
		-- Get number of nodes and distance betweene them
		NumGroundType,DistanceBetweeneEachNode = REAimplements:GetNumberOfGroundTypeNodes(Distance,DistanceEachNode,MinNumberNodes,MaxNumberNodes);
		OffsetInFront = 1;
		-- Each step for each node
		StepX = (x / (NumGroundType-1)) * Dir;
		StepY = (y / (NumGroundType-1)) * Dir;
		StepZ = (z / (NumGroundType-1)) * Dir;
	end;

	-- Create ground type node
	if PowerConsumer.GroundTypeNodes == nil then
		PowerConsumer.GroundTypeNodes = {};
		for Index=1, NumGroundType do
			table.insert(PowerConsumer.GroundTypeNodes, REAimplements:CreateNode(LeftNode,0,0,0,"GT" .. Index));
		end;
	end;

	-- Update position of ground type nodes
	for Index=1, NumGroundType do
		setTranslation(PowerConsumer.GroundTypeNodes[Index],(StepX*(Index-1))+(PlowOffset*PlowOffsetDir),StepY*(Index-1),(StepZ*(Index-1))+OffsetInFront);
	end;
end


-----------------------------------------------------------------------------------	
-- Function to get number of groundtype nodes to use
-----------------------------------------------------------------------------------
function REAimplements:GetNumberOfGroundTypeNodes(TotalDistance,DistanceEachNode,MinNumberNodes,MaxNumberNodes)
	local NumberOfNodes = MathUtil.clamp(REAimplements:RoundValue(TotalDistance / DistanceEachNode), MinNumberNodes, MaxNumberNodes);
	local DistanceBetweeneEachNode = TotalDistance / NumberOfNodes;
	return NumberOfNodes,DistanceBetweeneEachNode;
end


-----------------------------------------------------------------------------------	
-- deep dumps the contents of the table and it's contents' contents
-----------------------------------------------------------------------------------	
function REAimplements:deepdump( tbl )
    local checklist = {}
    local function innerdump( tbl, indent )
        checklist[ tostring(tbl) ] = true
        for k,v in pairs(tbl) do
            print(indent..k,v,type(v),checklist[ tostring(tbl) ])
            if (type(v) == "table" and not checklist[ tostring(v) ]) then innerdump(v,indent.."    ") end
        end
    end
    print("=== DEEPDUMP -----")
    checklist[ tostring(tbl) ] = true
    innerdump( tbl, "" )
    print("------------------")
end

-----------------------------------------------------------------------------------	
-- Function to round value with two decimals
-----------------------------------------------------------------------------------
function REAimplements:RoundValueTwoDecimals(x)
	x = x*100;
	x = x>=0 and math.floor(x+0.5) or math.ceil(x-0.5);
	x = x/100;
	return x;
end


-----------------------------------------------------------------------------------	
-- Function to smoothe value
-----------------------------------------------------------------------------------
function REAimplements:SmootheValue(SmoothedValue,RealValue)
	-- If no smoothevalue use the real value
	if SmoothedValue == nil then
		ActValue = RealValue;
	else
		ActValue = SmoothedValue;
	end;
	-- Return the smoothed value
	return (ActValue*0.9)+(RealValue*0.1);
end
function REAimplements:SlowSmootheValue(SmoothedValue,RealValue)
	-- If no smoothevalue use the real value
	if SmoothedValue == nil then
		ActValue = RealValue;
	else
		ActValue = SmoothedValue;
	end;
	-- Return the smoothed value
	return (ActValue*0.95)+(RealValue*0.05);
end


-----------------------------------------------------------------------------------	
-- Function to set new value during set time
-----------------------------------------------------------------------------------
function REAimplements:SetValueWithTime(ActValue,TargetValue,OriginalValue,Time,dt)
	-- If values nil return zero
	if ActValue == nil or TargetValue == nil then
		return 0;
	end;
	-- If differens change value over time
	if ActValue ~= TargetValue then
		-- If difference betweene original value and target value calculate differens
		local DiffValue = TargetValue - OriginalValue;
		-- Calculate how much is target should change
		local NewValue = ActValue + (DiffValue * (dt / Time));
		-- Check if new value is outside target area
		if NewValue > TargetValue and TargetValue > OriginalValue then
			NewValue = TargetValue;
		elseif NewValue < TargetValue and TargetValue < OriginalValue then
			NewValue = TargetValue;
		end;
		-- Return new value
		return NewValue;
	else
		-- If no differens return Target value
		return TargetValue;
	end;
end


-----------------------------------------------------------------------------------	
-- Update power multiplier for power consumers
-----------------------------------------------------------------------------------
function REAimplements:SpeedPowerRegulator(Input,Setpoint,outputMin,outputMax,LastOutput,Timer,dt)
	local timeStep = 50
	-- Add time to timer
	Timer = Timer + dt
	-- Run regulator
	if Timer > timeStep then
		-- Restart intervall timer
		Timer = 0;
		-- Calculate error
		local err = Setpoint - Input;
		-- Calculate ajustment value
		local Adjust = 0;
		if err ~= 0 then
			Adjust = err / 100;
		end;
		-- Calculate new output value
		local output = Adjust + LastOutput;
		-- Check if output in bounds
		if output > outputMax then
			output = outputMax
		elseif output < outputMin then
			output = outputMin
		end
		-- Smoothe value
		LastOutput = REAimplements:SmootheValue(LastOutput,output);
		-- Return new output
		return LastOutput, Timer;
	end;
	-- Return last output
	return LastOutput, Timer;
end;


-----------------------------------------------------------------------------------	
-- Function to return sideway force
-----------------------------------------------------------------------------------
function REAimplements:AppliedForce(ForwardForce,SidewayForce,ForcePosition)
	local TotalSpeed = ForcePosition.SidewaySpeed + ForcePosition.ForwardSpeed;
	local ForwardFactor = ForcePosition.ForwardSpeed / TotalSpeed;
	local SidewayFactor = ForcePosition.SidewaySpeed / TotalSpeed;
	local AppliedForwardForce = (ForwardForce * ForwardFactor) * ForcePosition.ForwardDirection;
	local AppliedSidewayForce = (SidewayForce * SidewayFactor) * ForcePosition.SidewayDirection;

	ForcePosition.ForwardForceSmoothed = REAimplements:SlowSmootheValue(ForcePosition.ForwardForceSmoothed,AppliedForwardForce);
	ForcePosition.SidewayForceSmoothed = REAimplements:SlowSmootheValue(ForcePosition.SidewayForceSmoothed,AppliedSidewayForce);

	return ForcePosition.ForwardForceSmoothed,ForcePosition.SidewayForceSmoothed;
end


-----------------------------------------------------------------------------------	
-- Function to get highest speed
-----------------------------------------------------------------------------------
function REAimplements:GetHighestSpeed(ForcePositions)
	local Speed = 0;
	for _, ForcePosition in pairs(ForcePositions) do
		if ForcePosition.ForwardSpeed > Speed then
			Speed = ForcePosition.ForwardSpeed;
		end;
		if ForcePosition.SidewaySpeed > Speed then
			Speed = ForcePosition.SidewaySpeed;
		end;
	end;
	return Speed;
end


function PowerConsumer:onUpdate(dt, isActiveForInput, isActiveForInputIgnoreSelection, isSelected)
    if self.isActive then
        local spec = self.spec_powerConsumer

        if spec.forceNode ~= nil and spec.MaxForceLeft ~= nil then
			if math.abs(spec.MaxForceLeft) > 0.1 or math.abs(spec.MaxForceRight) > 0.1 then
				local multiplier = self:getPowerMultiplier()
				if multiplier ~= 0 then
				local Speed = REAimplements:GetHighestSpeed(spec.ForcePosition);
					if Speed > 0.1 then
						local frictionForce = spec.forceFactor * Speed * 1000 * self:getTotalMass(false) / (dt/1000)

						-- REA: Add force to left and right side
						local px;
						local py;
						local pz;
						local dx;
						local dy;
						local dz;

						-- Left side
						local ForceEachNodeLeftSide = math.min((frictionForce * multiplier) / spec.NumberOfLeft, spec.MaxForceLeft / spec.NumberOfLeft);
						-- Right side
						local ForceEachNodeRightSide = math.min((frictionForce * multiplier) / spec.NumberOfRight, spec.MaxForceRight / spec.NumberOfRight);

						-- Get center of gravity for height of force
						local mx,my,mz = getCenterOfMass(spec.forceNode)

						-- DEBUG
						if REAimplements.Debug then
							if spec.FPNodeOffset == nil then
								spec.FPNodeOffset = REAimplements:CreateNode(spec.forceNode,0,2,0,"FPNodeOffset");
								spec.FPDNodeOffset = REAimplements:CreateNode(spec.forceDirNode,0,3,0,"FPDNodeOffset");
							end;
							local Name = "FPN";
							DebugUtil.drawDebugNode(spec.ForcePositionNode,Name, false);
							local Name = "FN";
							DebugUtil.drawDebugNode(spec.forceNode,Name, false);
							local Name = "FDN";
							DebugUtil.drawDebugNode(spec.forceDirNode,Name, false);

						end;

						for _, ForcePosition in pairs(spec.ForcePosition) do
							-- Force from left or right side
							local ForceForward = 0;
							if ForcePosition.IsLeft then
								ForceForward = ForceEachNodeLeftSide;
							elseif ForcePosition.IsRight then
								ForceForward = ForceEachNodeRightSide;
							end;
							local ForceSideWay = ForceForward * 2;

							-- If going backward increase force
							if self.movingDirection ~= spec.forceDir then
								ForceForward = ForceForward * 1.5;
							end;

							-- Add low force in low speed
							if Speed < 1 then
								ForceForward = ForceForward * Speed;
								ForceSideWay = ForceSideWay * Speed;
							end;

							local ForwardForce,SidewayForce = REAimplements:AppliedForce(ForceForward,ForceSideWay,ForcePosition);
							dx,dy,dz = localDirectionToWorld(spec.forceDirNode, -SidewayForce, 0, -ForwardForce)
							px,py,pz = localToLocal(ForcePosition.Node,spec.forceNode,0,0,0);
							addForce(spec.forceNode, dx,dy,dz, px,my,pz, true)

							-- DEBUG
							if REAimplements.Debug then

								if spec.DebugNodeNode == nil then
									spec.DebugNodeNode = REAimplements:CreateNode(spec.forceNode,0,0,0,"DebugNode");
								end;

								setTranslation(spec.DebugNodeNode,px,my,pz);

								local Name = "";
								if ForcePosition.IsLeft then
									Name = "L";
								elseif ForcePosition.IsRight then
									Name = "R";
								end;
								DebugUtil.drawDebugNode(spec.DebugNodeNode,Name .. REAimplements:RoundValueTwoDecimals(ForwardForce) .. "/" .. REAimplements:RoundValueTwoDecimals(SidewayForce), false);
								DebugUtil.drawDebugNode(ForcePosition.Node,Name, false);
							end;
	
						end;

		
						if (VehicleDebug.state == VehicleDebug.DEBUG_PHYSICS or VehicleDebug.state == VehicleDebug.DEBUG_TUNING) and self.isActiveForInputIgnoreSelectionIgnoreAI then
							local str = string.format("frictionForce=%.2f maxForce=%.2f -> force=%.2f", frictionForce, spec.maxForce, ForceForward)
							renderText(0.7, 0.85, getCorrectTextSize(0.02), str)
						end
					end
				end
			end
		end

        if spec.turnOnPeakPowerTimer > 0 then
            spec.turnOnPeakPowerTimer = spec.turnOnPeakPowerTimer - dt
        end
    end
end


if REAimplements.ModActivated == nil then

	addModEventListener(REAimplements);

	REAimplements.ModActivated = true;
	REAimplements.Debug = false;
	REAimplements.FilePath = g_currentModDirectory;
	print("mod activated")


end;
