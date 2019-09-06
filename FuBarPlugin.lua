if not ServTr then return end

local Tablet = AceLibrary('Tablet-2.0')

ServTrFu = AceLibrary('AceAddon-2.0'):new('AceDB-2.0', 'FuBarPlugin-2.0')
ServTrFu.hasIcon = 'Interface\\Icons\\inv_misc_note_04'

function ServTrFu:OnInitialize()
	self:RegisterDB('STFu_DB')
	
	self.title = 'Server Translation '..GetAddOnMetadata('Server_Translation', 'Version')
	self.titleWhenTooltipDetached = true
	self.defaultMinimapPosition = 180
	self.clickableTooltip = true
	self.cannotHideText = true
	self.hasNoColor = true
	
	self.OnMenuRequest = ServTr.options
	local args = AceLibrary('FuBarPlugin-2.0'):GetAceOptionsDataTable(self)
	for k, v in pairs(args) do
		if not self.OnMenuRequest.args[k] then
			self.OnMenuRequest.args[k] = v
		end
	end
end

function ServTrFu:OnTooltipUpdate()
	local cat1 = Tablet:AddCategory('columns', 2)
	cat1:AddLine('text', BINDING_NAME_TRANSLATE, 'func', 'OnlineTranslate', 'arg1', ServTr)
end