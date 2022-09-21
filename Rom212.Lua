-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local l__Lighting__2 = game:GetService("Lighting");
local l__ReplicatedStorage__3 = game:GetService("ReplicatedStorage");
local l__SoundService__4 = game:GetService("SoundService");
local l__Chat__5 = game:GetService("Chat");
local l__Terrain__6 = workspace.Terrain;
local u1 = nil;
function v1.init()
	u1 = _G.Sound;
end;
local l__UserId__2 = game:GetService("Players").LocalPlayer.UserId;
local u3 = {};
function v1.GetModelFromPart(p1)
	local l__Parent__7 = p1.Parent;
	for v8, v9 in pairs(u3) do
		if v9.model == l__Parent__7 then
			return l__Parent__7, v9.id;
		end;
	end;
	return false;
end;
function v1.GetPlayerModel(p2)
	if not u3[p2] then
		return;
	end;
	return u3[p2].model;
end;
function v1.Sleep(p3)
	if p3 == l__UserId__2 then
		local v10 = false;
	else
		local v11 = u3[p3];
		if not v11 then
			v10 = false;
		else
			v10 = v11;
		end;
	end;
	if not v10 then
		return;
	end;
	v10.anims.Sleep:Play();
	v10.lastPos = v10.pos;
	v10.velocity = Vector2.new(0, 0);
	v1.Slide(p3, false);
	v1.Crouch(p3, false);
	v1.UnEquipItem(p3);
	if math.random(1, 10) == 1 then
		v10.model.Head.Snore:Play();
	end;
end;
function v1.SetPlayerArmor(p4, p5)
	if p4 == l__UserId__2 then
		local v12 = false;
	else
		local v13 = u3[p4];
		if not v13 then
			v12 = false;
		else
			v12 = v13;
		end;
	end;
	if not v12 then
		return;
	end;
	local l__model__14 = v12.model;
	l__model__14.Armor:ClearAllChildren();
	p5 = p5 or {};
	for v15, v16 in pairs(p5) do
		for v17, v18 in pairs(l__ReplicatedStorage__3.ArmorModels[v16]:GetChildren()) do
			local v19 = v18:Clone();
			v19.Parent = l__model__14.Armor;
			local v20 = Instance.new("Weld");
			v20.Part0 = v19.PrimaryPart;
			v20.Part1 = l__model__14[v18.Name];
			v20.Parent = v19;
		end;
	end;
end;
function v1.Wake(p6)
	if p6 == l__UserId__2 then
		local v21 = false;
	else
		local v22 = u3[p6];
		if not v22 then
			v21 = false;
		else
			v21 = v22;
		end;
	end;
	if not v21 then
		return;
	end;
	v21.anims.Sleep:Stop();
end;
function v1.Remove(p7, p8)
	if p7 == l__UserId__2 then
		local v23 = false;
	else
		local v24 = u3[p7];
		if not v24 then
			v23 = false;
		else
			v23 = v24;
		end;
	end;
	if not v23 then
		return;
	end;
	v1.UnEquipItem(p7);
	u3[p7] = nil;
	v23.model.Parent = workspace.Ignore;
	if p8 then
		v23.model.PrimaryPart.Anchored = false;
		v23.model.PrimaryPart.AssemblyLinearVelocity = p8;
		for v25, v26 in pairs(v23.model:GetDescendants()) do
			if v26:IsA("Attachment") then
				v26:Destroy();
			end;
		end;
		for v27, v28 in pairs(v23.model:GetDescendants()) do
			if v28:IsA("Motor6D") then
				local v29 = Instance.new("Attachment");
				local v30 = Instance.new("Attachment");
				v29.CFrame = v28.C0;
				v30.CFrame = v28.C1;
				v29.Parent = v28.Part0;
				v30.Parent = v28.Part1;
				local v31 = Instance.new("BallSocketConstraint");
				v31.Attachment0 = v29;
				v31.Attachment1 = v30;
				v31.Parent = v28.Part0;
				v31.LimitsEnabled = true;
				v31.UpperAngle = 45;
				v31.TwistLowerAngle = -25;
				v31.TwistUpperAngle = 25;
				v28:Destroy();
			end;
		end;
		wait(3);
	end;
	v23.model:Destroy();
end;
function Lerp(p9, p10, p11)
	return p9 + (p10 - p9) * p11;
end;
local u4 = require(l__ReplicatedStorage__3.ItemConfigs);
function v1.ItemAction(p12, p13, ...)
	if p12 == l__UserId__2 then
		local v32 = false;
	else
		local v33 = u3[p12];
		if not v33 then
			v32 = false;
		else
			v32 = v33;
		end;
	end;
	if not v32 then
		return;
	end;
	if v32.equippedItem then
		local v34 = l__ReplicatedStorage__3.ClientControllers:FindFirstChild(u4[v32.equippedItem.id].Module);
		if not v34 then
			return;
		end;
		local v35 = require(v34);
		if not v35[p13] then
			error(p13);
		end;
		v35[p13](v32, u4[v32.equippedItem.id], ...);
	end;
end;
function v1.UnEquipItem(p14)
	if p14 == l__UserId__2 then
		local v36 = false;
	else
		local v37 = u3[p14];
		if not v37 then
			v36 = false;
		else
			v36 = v37;
		end;
	end;
	if not v36 then
		return;
	end;
	if v36.equippedItem then
		local v38 = l__ReplicatedStorage__3.ClientControllers:FindFirstChild(u4[v36.equippedItem.id].Module);
		if not v38 then
			return;
		end;
		require(v38).UnEquipToPlayer(v36, u4[v36.equippedItem.id]);
		v36.equippedItem = nil;
	end;
	v36.anims.Idle:Play();
end;
function v1.EquipItem(p15, p16)
	if p15 == l__UserId__2 then
		local v39 = false;
	else
		local v40 = u3[p15];
		if not v40 then
			v39 = false;
		else
			v39 = v40;
		end;
	end;
	if not v39 then
		return;
	end;
	v1.UnEquipItem(p15);
	if p16 then
		local v41 = l__ReplicatedStorage__3.ClientControllers:FindFirstChild(u4[p16.id].Module);
		if not v41 then
			return;
		end;
		v39.equippedItem = p16;
		require(v41).EquipToPlayer(v39, u4[p16.id]);
	end;
end;
function setAnimPlaying(p17, p18, p19)
	if p17 then
		if p17.IsPlaying then
			return;
		end;
	end;
	p18.Slide:Stop(p19);
	p18.Walk:Stop(p19);
	p18.Crouch:Stop(p19);
	p18.CrouchWalk:Stop(p19);
	if not p17 then
		return;
	end;
	p17:Play(p19);
end;
local l__Vector3_new__5 = Vector3.new;
local u6 = require(l__ReplicatedStorage__3.Maps.MaterialSounds);
function updatePlayers(p20)
	local v42, v43, v44 = pairs(u3);
	while true do
		local v45, v46 = v42(v43, v44);
		if v45 then

		else
			break;
		end;
		v44 = v45;
		if v46.model then
			if v46.model.PrimaryPart then
				local l__PrimaryPart__47 = v46.model.PrimaryPart;
				local v48 = math.clamp(1 / ((v46.pos - l__PrimaryPart__47.Position).Magnitude * 5), 0.17, 0.5);
				local v49 = Vector2.new(v46.lastPos.X, v46.lastPos.Z) - Vector2.new(v46.pos.X, v46.pos.Z);
				v46.velocity = v46.velocity:Lerp(v49, v48);
				local l__Magnitude__50 = v49.Magnitude;
				if v49.Magnitude < 1 then
					v46.velocity = Vector2.new(0, 0);
				end;
				v46.anims.Walk:AdjustSpeed(Lerp(v46.anims.Walk.Speed, l__Magnitude__50 * 0.65, 0.2));
				v46.moving = 0.05 < l__Magnitude__50;
				local v51 = false;
				if v46.sliding then
					setAnimPlaying(v46.anims.Slide, v46.anims);
				else
					if v46.moving then
						if v46.crouching then
							setAnimPlaying(v46.anims.CrouchWalk, v46.anims, 0.1);
							v51 = true;
						else
							setAnimPlaying(v46.anims.Walk, v46.anims, 0.1);
							v51 = true;
						end;
					elseif v46.crouching then
						setAnimPlaying(v46.anims.Crouch, v46.anims, 0.2);
						v51 = true;
					end;
					if not v51 then
						setAnimPlaying(nil, v46.anims, 0.2);
					end;
				end;
				local v52 = v46.goals[math.floor(v46.goalindex)];
				if v52 then
					v46.model:SetPrimaryPartCFrame(l__PrimaryPart__47.CFrame:Lerp(CFrame.new(v52 + Vector3.new(-v46.velocity.X, 0.5, -v46.velocity.Y)) * CFrame.fromOrientation(0, v46.angleY, 0), v48));
				end;
				v46.goalindex = v46.goalindex + p20 * 7;
				v46.model.UpperTorso.Waist.C0 = v46.model.UpperTorso.Waist.C0:Lerp(CFrame.new(0, 0.2, 0.05) * CFrame.fromOrientation(v46.angleX * 0.3, 0, 0), v48);
				v46.model.Head.Neck.C0 = v46.model.Head.Neck.C0:Lerp(CFrame.new(0, 1.1, 0.05) * CFrame.fromOrientation(v46.angleX * 0.6, 0, 0), v48);
				local v53 = RaycastParams.new();
				v53.FilterDescendantsInstances = { workspace.Ignore, v46.model };
				v53.FilterType = Enum.RaycastFilterType.Blacklist;
				local v54 = workspace:Raycast(v46.pos, l__Vector3_new__5(0, -3.75, 0), v53);
				local v55 = workspace:Raycast(v46.pos + l__Vector3_new__5(0.75, 0, 0.75), l__Vector3_new__5(0, -3.5, 0), v53);
				local v56 = workspace:Raycast(v46.pos + l__Vector3_new__5(-0.75, 0, -0.75), l__Vector3_new__5(0, -3.5, 0), v53);
				local v57 = workspace:Raycast(v46.pos + l__Vector3_new__5(-0.75, 0, 0.75), l__Vector3_new__5(0, -3.5, 0), v53);
				local v58 = workspace:Raycast(v46.pos + l__Vector3_new__5(0.75, 0, -0.75), l__Vector3_new__5(0, -3.5, 0), v53);
				local v59 = false;
				local v60 = nil;
				if not v54 then
					if not v55 then
						if not v56 then
							if not v57 then
								if v58 then
									v60 = v55 and v55.Material or (v54 and v54.Material or (v56 and v56.Material or (v57 and v57.Material or v58 and v58.Material)));
									v59 = true;
								end;
							else
								v60 = v55 and v55.Material or (v54 and v54.Material or (v56 and v56.Material or (v57 and v57.Material or v58 and v58.Material)));
								v59 = true;
							end;
						else
							v60 = v55 and v55.Material or (v54 and v54.Material or (v56 and v56.Material or (v57 and v57.Material or v58 and v58.Material)));
							v59 = true;
						end;
					else
						v60 = v55 and v55.Material or (v54 and v54.Material or (v56 and v56.Material or (v57 and v57.Material or v58 and v58.Material)));
						v59 = true;
					end;
				else
					v60 = v55 and v55.Material or (v54 and v54.Material or (v56 and v56.Material or (v57 and v57.Material or v58 and v58.Material)));
					v59 = true;
				end;
				v46.footStepProgression = v46.footStepProgression + (Vector2.new(v46.lastFootStepPos.X, v46.lastFootStepPos.Z) - Vector2.new(v46.pos.X, v46.pos.Z)).Magnitude;
				v46.lastFootStepPos = v46.pos;
				if 4 < v46.footStepProgression then
					if v59 then
						if not v46.sliding then
							v46.footStepProgression = 0;
							if not v46.crouching then
								u1.play(u6[v60], v46.pos, math.random(-10, 10) / 350, 0);
							end;
						end;
					end;
				end;
			end;
		end;	
	end;
end;
game:GetService("RunService").RenderStepped:Connect(updatePlayers);
function v1.Move(p21, p22, p23, p24)
	local v61 = u3[p21];
	if v61 then
		v61.lastPos = v61.pos;
		v61.pos = p22;
		v61.angleX = p23;
		v61.angleY = p24;
		v61.goalindex = 1;
		v61.goals = {};
		local v62 = Vector2.new(v61.lastPos.X, v61.lastPos.Z) - Vector2.new(v61.pos.X, v61.pos.Z);
		for v63 = 1, 7 do
			v61.goals[v63] = v61.lastPos:Lerp(p22 + Vector3.new(-v62.X, 0, -v62.Y), 0.14285714285714285 * v63);
		end;
	end;
end;
function v1.Slide(p25, p26)
	if p25 == l__UserId__2 then
		local v64 = false;
	else
		local v65 = u3[p25];
		if not v65 then
			v64 = false;
		else
			v64 = v65;
		end;
	end;
	if not v64 then
		return;
	end;
	v64.sliding = p26;
	if p26 then
		u1.play("SlideStart", v64.pos);
		v64.model.Head.Sliding:Play();
		return;
	end;
	u1.play("SlideStop", v64.pos);
	v64.model.Head.Sliding:Stop();
end;
function v1.Crouch(p27, p28)
	if p27 == l__UserId__2 then
		local v66 = false;
	else
		local v67 = u3[p27];
		if not v67 then
			v66 = false;
		else
			v66 = v67;
		end;
	end;
	if not v66 then
		return;
	end;
	v66.crouching = p28;
end;
local u7 = {};
local u8 = false;
local function u9(p29)
	local l__model__68 = p29.model;
	if u8 then
		l__model__68.Head.ESP.Enabled = true;
		l__model__68.Head.ESP.tag.Text = p29.name;
	else
		l__model__68.Head.ESP.Enabled = false;
	end;
	if table.find(u7, p29.id) then
		l__model__68.Head.Nametag.Enabled = false;
		l__model__68.Head.Dot.Enabled = true;
		l__model__68.Head.Dot2.Enabled = true;
		l__model__68.Head.Teamtag.Enabled = true;
		l__model__68.Head.Teamtag.tag.Text = p29.name;
		return;
	end;
	l__model__68.Head.Nametag.Enabled = true;
	l__model__68.Head.Dot.Enabled = false;
	l__model__68.Head.Dot2.Enabled = false;
	l__model__68.Head.Teamtag.Enabled = false;
	l__model__68.Head.Nametag.tag.Text = p29.name;
end;
function v1.SetClanMembers(p30)
	u7 = p30 or {};
	for v69, v70 in pairs(u3) do
		u9(v70);
	end;
end;
function v1.SetEsp(p31)
	u8 = p31;
	for v71, v72 in pairs(u3) do
		u9(v72);
	end;
end;
function v1.LoadNewPlayer(p32, p33, p34, p35)
	if p32 == l__UserId__2 then
		return;
	end;
	if u3[p32] then
		v1.Remove(p32);
	end;
	local v73 = l__ReplicatedStorage__3.Player:Clone();
	v73.Name = "Model";
	local v74 = {};
	v73:SetPrimaryPartCFrame(CFrame.new(p33));
	u3[p32] = {
		goals = {}, 
		goalindex = 1, 
		name = p35.name, 
		model = v73, 
		pos = p33, 
		angleX = 0, 
		angleY = 0, 
		crouching = false, 
		sprinting = false, 
		sliding = false, 
		lastFootStepPos = Vector3.new(0, 0, 0), 
		footStepProgression = 0, 
		anims = v74, 
		moving = false, 
		nextLowPitch = false, 
		grounded = false, 
		groundMaterial = nil, 
		equippedItem = nil, 
		handModel = nil, 
		cancelEquip = nil, 
		id = p32, 
		lastPos = p33, 
		velocity = Vector2.new(0, 0)
	};
	u9(u3[p32]);
	v73.Parent = workspace;
	v73.BodyColors.HeadColor3 = p34;
	v73.BodyColors.LeftArmColor3 = p34;
	v73.BodyColors.LeftLegColor3 = p34;
	v73.BodyColors.RightArmColor3 = p34;
	v73.BodyColors.RightLegColor3 = p34;
	v73.BodyColors.TorsoColor3 = p34;
	for v75, v76 in pairs(l__ReplicatedStorage__3.Animations:GetChildren()) do
		if v76:IsA("Animation") then
			v74[v76.Name] = v73.Humanoid.Animator:LoadAnimation(v76);
		end;
	end;
	for v77, v78 in pairs(l__ReplicatedStorage__3.Animations.Arms:GetChildren()) do
		v74[v78.Name] = v73.Humanoid.Animator:LoadAnimation(v78);
	end;
	v74.Idle:Play();
	if p35.equippedItem then
		v1.EquipItem(p32, p35.equippedItem);
	end;
	if p35.crouching then
		v1.Crouch(p32, true);
	end;
	if p35.sliding then
		v1.Slide(p32, true);
	end;
	if p35.sleeping then
		v1.Sleep(p32);
	end;
	if p35.armor then
		v1.SetPlayerArmor(p32, p35.armor);
	end;
end;
return v1;
