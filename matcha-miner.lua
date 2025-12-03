local _Byte = string.char
local function _Str(...)
    local _r = ""
    local _t = {...}
    for _i = 1, #_t do
        _r = _r .. _Byte(_t[_i])
    end
    return _r
end

local _P_Serv = game:GetService(_Str(80, 108, 97, 121, 101, 114, 115))
local _LP = _P_Serv.LocalPlayer
if not _LP then
    repeat
        wait(1)
        _LP = _P_Serv.LocalPlayer
    until _LP
end

local _0x1A = {}
_0x1A.__index = _0x1A

local _ESP_F = 13
local _Col_Black = Color3.new(0, 0, 0)
local _Me = _LP
local _Ms = _Me:GetMouse()

local function _Clamp(_x, _a, _b) if _x > _b then return _b elseif _x < _a then return _a else return _x end end
local function _GetMsPos() return Vector2.new(_Ms.X, _Ms.Y) end
local function _Lerp(_a, _b, _t) return _a + (_b - _a) * _t end
local function _Undraw(_t) for _, _d in pairs(_t) do _d.Visible = false end end
local function _KillDraw(_t) for _, _d in pairs(_t) do _d:Remove() end end

function _0x1A.new(_n, _s, _wmAct)
    local _self = setmetatable({}, _0x1A)
    
    _self._in = { ['m1']={id=0x01,held=false,click=false}, ['end']={id=0x23,held=false,click=false} } 
    _self._atab = nil
    _self._op = true
    _self._last_op = nil 
    _self._wm = true
    _self._b_op = 0
    _self._tk = os.clock()
    _self._id = _n
    _self._wm_act = _wmAct
    _self.x, _self.y = 20, 60
    _self.w = _s and _s.x or 300
    _self.h = _s and _s.y or 400
    _self._act_dd = nil 

    _self._c_acc = Color3.fromRGB(255, 127, 0)
    _self._c_txt = Color3.fromRGB(255, 255, 255)
    _self._c_crust = Color3.fromRGB(0, 0, 0)
    _self._c_bord = Color3.fromRGB(25, 25, 25)
    _self._c_surf = Color3.fromRGB(38, 38, 38)
    _self._c_ovr = Color3.fromRGB(76, 76, 76)
    _self._ti_h, _self._tb_h, _self._pad = 25, 20, 6
    
    local function _NewDrw(_t, _p) 
        local _d = Drawing.new(_t); for _k,_v in pairs(_p) do _d[_k]=_v end; return _d 
    end

    local _base = _NewDrw(_Str(83, 113, 117, 97, 114, 101), {Filled=true, Color=_self._c_surf})
    local _crust = _NewDrw(_Str(83, 113, 117, 97, 114, 101), {Filled=false, Thickness=1, Color=_self._c_crust})
    local _border = _NewDrw(_Str(83, 113, 117, 97, 114, 101), {Filled=false, Thickness=1, Color=_self._c_bord})
    local _navbar = _NewDrw(_Str(83, 113, 117, 97, 114, 101), {Filled=true, Color=_self._c_bord})
    local _title = _NewDrw(_Str(84, 101, 120, 116), {Text=_self._id, Outline=true, Color=_self._c_txt})
    
    local _wmBase = _NewDrw(_Str(83, 113, 117, 97, 114, 101), {Filled=true, Color=_self._c_surf})
    local _wmCursor = _NewDrw(_Str(83, 113, 117, 97, 114, 101), {Filled=true, Color=_self._c_acc})
    local _wmCrust = _NewDrw(_Str(83, 113, 117, 97, 114, 101), {Filled=false, Thickness=1, Color=_self._c_crust})
    local _wmBorder = _NewDrw(_Str(83, 113, 117, 97, 114, 101), {Filled=false, Thickness=1, Color=_self._c_bord})
    local _wmText = _NewDrw(_Str(84, 101, 120, 116), {Text=_n, Outline=true, Color=_self._c_txt})

    _self._tree = {['_tabs']={}, ['_drawings']={_crust, _border, _base, _navbar, _title, _wmBase, _wmCursor, _wmCrust, _wmBorder, _wmText}}
    return _self
end

function _0x1A._GetTextBounds(_s) return #_s * 7, 13 end 

function _0x1A._IsMouseWithinBounds(_o, _s) 
    local _m = _GetMsPos()
    return _m.x >= _o.x and _m.x <= _o.x + _s.x and _m.y >= _o.y and _m.y <= _o.y + _s.y 
end

function _0x1A:ToggleMenu(_s) self._op = _s end

function _0x1A:_RemoveDropdown()
    if self._act_dd then
        _KillDraw(self._act_dd['_drawings'])
        self._act_dd = nil
    end
end

function _0x1A:_SpawnDropdown(_d, _c, _cb, _p, _w)
    if self._act_dd then self:_RemoveDropdown() end
    local _drws = {}
    local _base = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _base.Filled=true; _base.Color=self._c_surf; table.insert(_drws, _base)
    local _border = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _border.Filled=false; _border.Thickness=1; _border.Color=self._c_bord; table.insert(_drws, _border)

    for _, _ch in ipairs(_c) do
        local _t = Drawing.new(_Str(84, 101, 120, 116)); _t.Outline=true; _t.Color=self._c_txt; _t.Text=_ch; table.insert(_drws, _t)
    end

    self._act_dd = {['choices']=_c, ['callback']=_cb, ['pos']=_p, ['w']=_w, ['_drawings']=_drws}
end

function _0x1A:Tab(_n)
    local _bd = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _bd.Color=self._c_bord; _bd.Filled=true
    local _sh = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _sh.Color=_Col_Black; _sh.Filled=true
    local _cu = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _cu.Color=self._c_acc; _cu.Filled=true
    local _tx = Drawing.new(_Str(84, 101, 120, 116)); _tx.Color=self._c_txt; _tx.Outline=true; _tx.Text=_n
    table.insert(self._tree['_tabs'], {['name']=_n, ['_sections']={}, ['_drawings']={_bd, _sh, _cu, _tx}})
    if self._atab == nil then self._atab = _n end
    return _n
end

function _0x1A:Section(_tN, _n)
    for _, _t in ipairs(self._tree['_tabs']) do
        if _t['name'] == _tN then
            local _b = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _b.Filled=true; _b.Color=self._c_surf
            local _c = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _c.Filled=false; _c.Thickness=1; _c.Color=self._c_crust
            local _bo = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _bo.Filled=false; _bo.Thickness=1; _bo.Color=self._c_ovr
            local _ti = Drawing.new(_Str(84, 101, 120, 116)); _ti.Text=_n; _ti.Outline=true; _ti.Color=self._c_txt
            local _sec = {['name']=_n, ['_items']={}, ['_drawings']={_b, _c, _bo, _ti}}
            table.insert(_t._sections, _sec)
            return _n
        end
    end
end

function _0x1A:_AddToSection(_tN, _sN, _it)
    for _, _t in pairs(self._tree._tabs) do
        if _t.name == _tN then
            for _, _s in pairs(_t._sections) do
                if _s.name == _sN then
                    table.insert(_s._items, _it)
                    return
                end
            end
        end
    end
end

function _0x1A:Checkbox(_tN, _sN, _l, _dV, _cb)
    local _out = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _out.Color=self._c_crust; _out.Thickness=1; _out.Filled=false
    local _chk = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _chk.Color=self._c_acc; _chk.Filled=true
    local _sh = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _sh.Color=_Col_Black; _sh.Filled=true
    local _tx = Drawing.new(_Str(84, 101, 120, 116)); _tx.Color=self._c_txt; _tx.Outline=true; _tx.Text=_l
    self:_AddToSection(_tN, _sN, {['type']=_Str(99, 104, 101, 99, 107, 98, 111, 120), ['value']=_dV, ['callback']=_cb, ['_drawings']={_out, _chk, _sh, _tx}})
end

function _0x1A:Slider(_tN, _sN, _l, _dV, _cb, _min, _max, _step, _app)
    local _out = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _out.Color=self._c_crust; _out.Filled=true
    local _fil = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _fil.Color=self._c_acc; _fil.Filled=true
    local _sh = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _sh.Color=_Col_Black; _sh.Filled=true
    local _val = Drawing.new(_Str(84, 101, 120, 116)); _val.Color=self._c_txt; _val.Outline=true; _val.Text=_l
    local _tx = Drawing.new(_Str(84, 101, 120, 116)); _tx.Color=self._c_txt; _tx.Outline=true; _tx.Text=_l
    self:_AddToSection(_tN, _sN, {['type']=_Str(115, 108, 105, 100, 101, 114), ['value']=_dV, ['callback']=_cb, ['min']=_min, ['max']=_max, ['step']=_step, ['appendix']=_app, ['_drawings']={_out, _fil, _sh, _val, _tx}})
end

function _0x1A:Choice(_tN, _sN, _l, _dV, _cb, _ch)
    local _out = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _out.Color=self._c_crust; _out.Thickness=1; _out.Filled=false
    local _fil = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _fil.Color=self._c_crust; _fil.Filled=true
    
    local _iTxt = _dV
    if type(_dV) == _Str(116, 97, 98, 108, 101) then
        if #_dV == 0 then _iTxt = _Str(78, 111, 110, 101)
        else _iTxt = table.concat(_dV, _Str(44, 32)) end
    end
    
    local _vTx = Drawing.new(_Str(84, 101, 120, 116)); _vTx.Color=self._c_txt; _vTx.Outline=true; _vTx.Text=tostring(_iTxt)
    local _lTx = Drawing.new(_Str(84, 101, 120, 116)); _lTx.Color=self._c_txt; _lTx.Outline=true; _lTx.Text=_l
    local _it = {['type']=_Str(99, 104, 111, 105, 99, 101), ['value']=_dV, ['callback']=_cb, ['choices']=_ch, ['_drawings']={_out, _fil, _vTx, _lTx}}
    self:_AddToSection(_tN, _sN, _it)
    return _it
end

function _0x1A:DualChoice(_tN, _sN, _l1, _d1, _cb1, _ch1, _l2, _d2, _cb2, _ch2)
    local _o1 = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _o1.Color=self._c_crust; _o1.Thickness=1; _o1.Filled=false
    local _f1 = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _f1.Color=self._c_crust; _f1.Filled=true
    local _v1 = Drawing.new(_Str(84, 101, 120, 116)); _v1.Color=self._c_txt; _v1.Outline=true; _v1.Text=tostring(_d1)
    local _lb1 = Drawing.new(_Str(84, 101, 120, 116)); _lb1.Color=self._c_txt; _lb1.Outline=true; _lb1.Text=_l1

    local _o2 = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _o2.Color=self._c_crust; _o2.Thickness=1; _o2.Filled=false
    local _f2 = Drawing.new(_Str(83, 113, 117, 97, 114, 101)); _f2.Color=self._c_crust; _f2.Filled=true
    local _v2 = Drawing.new(_Str(84, 101, 120, 116)); _v2.Color=self._c_txt; _v2.Outline=true; _v2.Text=tostring(_d2)
    local _lb2 = Drawing.new(_Str(84, 101, 120, 116)); _lb2.Color=self._c_txt; _lb2.Outline=true; _lb2.Text=_l2

    local _it = {
        ['type']=_Str(100, 117, 97, 108, 95, 99, 104, 111, 105, 99, 101), 
        ['v1']=_d1, ['cb1']=_cb1, ['ch1']=_ch1, 
        ['v2']=_d2, ['cb2']=_cb2, ['ch2']=_ch2,
        ['_drawings']={_o1, _f1, _v1, _lb1, _o2, _f2, _v2, _lb2}
    }
    self:_AddToSection(_tN, _sN, _it)
    return _it
end

function _0x1A:Step()
    local _dt = math.max(os.clock() - self._tk, 0.0035)
    local _mp = _GetMsPos()
    local _m1 = iskeypressed(0x01); if _m1 and not self._in.m1.held then self._in.m1.click = true else self._in.m1.click = false end; self._in.m1.held = _m1
    local _mOp = self._op
    local _clk = _mOp and self._in.m1.click
    local _bOp = self._b_op
    local _cVis = _bOp > 0.22
    self._b_op = _Clamp(_Lerp(_bOp, _mOp and 1 or 0, _dt * 11), 0, 1)

    if self._last_op ~= _mOp then setrobloxinput(not _mOp); self._last_op = _mOp end

    local _wB, _wC, _wCr, _wBr, _wT = unpack(self._tree['_drawings'], 6, 10)
    if self._wm then
        local _sT = self._id
        if self._wm_act then for _, _a in ipairs(self._wm_act) do local _s = _a(); if _s then _sT = _sT .. _Str(32, 124, 32) .. _s end end end
        local _wW = #_sT * 7
        local _wP = Vector2.new(20, 20); local _wS = Vector2.new(_wW + 18, 30)
        _wB.Position = _wP; _wB.Size = _wS; _wB.Visible = true
        _wCr.Position = _wP; _wCr.Size = _wS; _wCr.Visible = true
        _wBr.Position = _wP + Vector2.new(1,1); _wBr.Size = _wS + Vector2.new(-2,-2); _wBr.Visible = true
        _wC.Position = _wP + Vector2.new(2,2); _wC.Size = Vector2.new(_wS.x-4, 1); _wC.Visible = true
        _wT.Position = _wP + Vector2.new(8, 8); _wT.Text = _sT; _wT.Visible = true
    else _wB.Visible = false; _wT.Visible = false end

    local _uCr, _uBr, _uB, _uN, _uT = unpack(self._tree['_drawings'], 1, 5)
    _uB.Position = Vector2.new(self.x, self.y); _uB.Size = Vector2.new(self.w, self.h); _uB.Transparency = _bOp; _uB.Visible = _cVis
    _uBr.Position = Vector2.new(self.x+1, self.y+1); _uBr.Size = Vector2.new(self.w-2, self.h-2); _uBr.Transparency = _bOp; _uBr.Visible = _cVis
    _uCr.Position = Vector2.new(self.x, self.y); _uCr.Size = Vector2.new(self.w, self.h); _uCr.Transparency = _bOp; _uCr.Visible = _cVis
    _uN.Position = Vector2.new(self.x+2, self.y+2); _uN.Size = Vector2.new(self.w-4, self._ti_h-4); _uN.Transparency = _bOp; _uN.Visible = _cVis
    _uT.Position = Vector2.new(self.x+7, self.y+4); _uT.Transparency = _bOp; _uT.Visible = _cVis

    local _tR = Vector2.new(self.w, self._ti_h)
    if self._IsMouseWithinBounds(Vector2.new(self.x, self.y), _tR) and _clk then self._drag = true; self._d_off = _mp - Vector2.new(self.x, self.y) end
    if self._drag then if self._in.m1.held then self.x = _mp.x - self._d_off.x; self.y = _mp.y - self._d_off.y else self._drag = false end end

    local _nT = #self._tree['_tabs']
    for _ti, _tb in ipairs(self._tree['_tabs']) do
        local _tOp = self._atab == _tb['name']
        local _tW = (self.w - 12 - (_nT - 1) * 2) / _nT
        local _tP = Vector2.new(self.x + 6 + (_ti-1)*(_tW+2), self.y + self._ti_h + 6)
        _tb['_drawings'][1].Position = _tP; _tb['_drawings'][1].Size = Vector2.new(_tW, self._tb_h); _tb['_drawings'][1].Transparency = _bOp; _tb['_drawings'][1].Visible = _cVis
        _tb['_drawings'][3].Position = _tP; _tb['_drawings'][3].Size = Vector2.new(_tW, 1); _tb['_drawings'][3].Transparency = _bOp; _tb['_drawings'][3].Visible = _tOp and _cVis
        _tb['_drawings'][4].Position = _tP + Vector2.new(4, 4); _tb['_drawings'][4].Transparency = _bOp; _tb['_drawings'][4].Visible = _cVis
        if _clk and self._IsMouseWithinBounds(_tP, Vector2.new(_tW, self._tb_h)) then self._atab = _tb['name'] end

        if _tOp then
            local _sY = self._pad * 2 + self._tb_h + self._ti_h
            for _, _sec in ipairs(_tb['_sections']) do
                local _sP = Vector2.new(self.x + 10, self.y + _sY)
                local _sW = self.w - 20
                local _iY = 20
                for _, _it in ipairs(_sec._items) do
                    local _iP = _sP + Vector2.new(10, _iY)
                    if _it.type == _Str(99, 104, 101, 99, 107, 98, 111, 120) then
                        local _bS = Vector2.new(15, 15)
                        _it._drawings[1].Position = _iP; _it._drawings[1].Size = _bS; _it._drawings[1].Visible = _cVis
                        _it._drawings[2].Position = _iP+Vector2.new(1,1); _it._drawings[2].Size = _bS-Vector2.new(2,2); _it._drawings[2].Visible = _it.value and _cVis
                        _it._drawings[3].Position = _iP+Vector2.new(1,_bS.y-2); _it._drawings[3].Size = Vector2.new(_bS.x-2,1); _it._drawings[3].Visible = _it.value and _cVis
                        _it._drawings[4].Position = _iP+Vector2.new(22, 0); _it._drawings[4].Visible = _cVis
                        if self._IsMouseWithinBounds(_iP, Vector2.new(_sW - 20, 16)) and _clk then _it.value = not _it.value; if _it.callback then _it.callback(_it.value) end end
                        _iY = _iY + 25
                    elseif _it.type == _Str(115, 108, 105, 100, 101, 114) then
                         local _slW = _sW - 30
                         _it._drawings[5].Position = _iP; _it._drawings[5].Visible = _cVis
                         _it._drawings[1].Position = _iP + Vector2.new(0, 15); _it._drawings[1].Size = Vector2.new(_slW, 10); _it._drawings[1].Visible = _cVis
                         local _pct = (_it.value - _it.min) / (_it.max - _it.min)
                         _it._drawings[2].Position = _iP + Vector2.new(1, 16); _it._drawings[2].Size = Vector2.new((_slW-2)*_pct, 8); _it._drawings[2].Visible = _cVis
                         _it._drawings[4].Position = _iP + Vector2.new(_slW - 40, 0); _it._drawings[4].Text = tostring(_it.value) .. (_it.appendix or ""); _it._drawings[4].Visible = _cVis
                         if self._in.m1.held and self._IsMouseWithinBounds(_iP + Vector2.new(0, 15), Vector2.new(_slW, 10)) then
                             local _mx = _mp.x - (_iP.x); local _nPt = _Clamp(_mx/_slW, 0, 1); local _nVal = math.floor((_it.min + (_it.max-_it.min)*_nPt) / _it.step + 0.5) * _it.step
                             if _nVal ~= _it.value then _it.value = _nVal; if _it.callback then _it.callback(_nVal) end end
                         end
                         _iY = _iY + 35
                    elseif _it.type == _Str(99, 104, 111, 105, 99, 101) then
                        local _chW = _sW - 30; local _chH = 20
                        _it._drawings[4].Position = _iP; _it._drawings[4].Visible = _cVis 
                        _it._drawings[1].Position = _iP + Vector2.new(0, 15); _it._drawings[1].Size = Vector2.new(_chW, _chH); _it._drawings[1].Visible = _cVis
                        _it._drawings[2].Position = _iP + Vector2.new(2, 17); _it._drawings[2].Size = Vector2.new(_chW-4, _chH-4); _it._drawings[2].Visible = _cVis
                        
                        local _dTx = _it.value
                        if type(_it.value) == _Str(116, 97, 98, 108, 101) then
                            if #_it.value > 0 then
                                _dTx = table.concat(_it.value, _Str(44, 32))
                                if #_dTx > 20 then _dTx = #_it.value .. _Str(32, 115, 101, 108, 101, 99, 116, 101, 100) end
                            else _dTx = _Str(78, 111, 110, 101) end
                        end
                        _it._drawings[3].Position = _iP + Vector2.new(4, 18); _it._drawings[3].Text = tostring(_dTx); _it._drawings[3].Visible = _cVis
                        
                        if _clk and self._IsMouseWithinBounds(_iP + Vector2.new(0, 15), Vector2.new(_chW, _chH)) then
                            local _cb = function(_val) 
                                if type(_it.value) == _Str(116, 97, 98, 108, 101) then
                                    local _fnd = false
                                    for _i, _v in ipairs(_it.value) do if _v == _val then table.remove(_it.value, _i); _fnd = true; break end end
                                    if not _fnd then table.insert(_it.value, _val) end
                                    if _it.callback then _it.callback(_it.value) end
                                else _it.value = _val; if _it.callback then _it.callback(_val) end end
                            end
                            _clk = false 
                            self:_SpawnDropdown(_it.value, _it.choices, _cb, _iP + Vector2.new(0, 35), _chW)
                        end
                        _iY = _iY + 40
                    elseif _it.type == _Str(100, 117, 97, 108, 95, 99, 104, 111, 105, 99, 101) then
                        local _fW = _sW - 30; local _hW = (_fW / 2) - 5
                        local _cH = 20
                        local _p1 = _iP + Vector2.new(0, 15)
                        local _p2 = _iP + Vector2.new(_hW + 10, 15)

                        _it._drawings[4].Position = _iP; _it._drawings[4].Visible = _cVis 
                        _it._drawings[1].Position = _p1; _it._drawings[1].Size = Vector2.new(_hW, _cH); _it._drawings[1].Visible = _cVis
                        _it._drawings[2].Position = _p1 + Vector2.new(1, 1); _it._drawings[2].Size = Vector2.new(_hW-2, _cH-2); _it._drawings[2].Visible = _cVis
                        
                        local _dt1 = _it.v1
                        if type(_dt1) == _Str(116, 97, 98, 108, 101) then
                            if #_dt1 > 0 then _dt1 = table.concat(_dt1, _Str(44, 32)); if #_dt1 > 10 then _dt1 = #_it.v1.._Str(32, 115, 101, 108) end else _dt1 = _Str(78, 111, 110, 101) end
                        end
                        _it._drawings[3].Position = _p1 + Vector2.new(4, 3); _it._drawings[3].Text = tostring(_dt1); _it._drawings[3].Visible = _cVis

                        _it._drawings[8].Position = _iP + Vector2.new(_hW + 10, 0); _it._drawings[8].Visible = _cVis
                        _it._drawings[5].Position = _p2; _it._drawings[5].Size = Vector2.new(_hW, _cH); _it._drawings[5].Visible = _cVis
                        _it._drawings[6].Position = _p2 + Vector2.new(1, 1); _it._drawings[6].Size = Vector2.new(_hW-2, _cH-2); _it._drawings[6].Visible = _cVis
                        
                        local _dt2 = _it.v2
                        if type(_dt2) == _Str(116, 97, 98, 108, 101) then
                            if #_dt2 > 0 then _dt2 = table.concat(_dt2, _Str(44, 32)); if #_dt2 > 10 then _dt2 = #_it.v2.._Str(32, 115, 101, 108) end else _dt2 = _Str(78, 111, 110, 101) end
                        end
                        _it._drawings[7].Position = _p2 + Vector2.new(4, 3); _it._drawings[7].Text = tostring(_dt2); _it._drawings[7].Visible = _cVis

                        if _clk and self._IsMouseWithinBounds(_p1, Vector2.new(_hW, _cH)) then
                            local _cb = function(_val)
                                if type(_it.v1) == _Str(116, 97, 98, 108, 101) then
                                    local _fnd = false
                                    for _i, _v in ipairs(_it.v1) do if _v == _val then table.remove(_it.v1, _i); _fnd = true; break end end
                                    if not _fnd then table.insert(_it.v1, _val) end
                                    if _it.cb1 then _it.cb1(_it.v1) end
                                else _it.v1 = _val; if _it.cb1 then _it.cb1(_val) end end
                            end
                            _clk = false; self:_SpawnDropdown(_it.v1, _it.ch1, _cb, _p1 + Vector2.new(0, _cH), _hW)
                        end
                        if _clk and self._IsMouseWithinBounds(_p2, Vector2.new(_hW, _cH)) then
                            local _cb = function(_val)
                                if type(_it.v2) == _Str(116, 97, 98, 108, 101) then
                                    local _fnd = false
                                    for _i, _v in ipairs(_it.v2) do if _v == _val then table.remove(_it.v2, _i); _fnd = true; break end end
                                    if not _fnd then table.insert(_it.v2, _val) end
                                    if _it.cb2 then _it.cb2(_it.v2) end
                                else _it.v2 = _val; if _it.cb2 then _it.cb2(_val) end end
                            end
                            _clk = false; self:_SpawnDropdown(_it.v2, _it.ch2, _cb, _p2 + Vector2.new(0, _cH), _hW)
                        end
                        
                        _iY = _iY + 40
                    end
                end
                _sec._drawings[4].Position = _sP + Vector2.new(10, -8); _sec._drawings[4].Visible = _cVis
                _sec._drawings[3].Position = _sP; _sec._drawings[3].Size = Vector2.new(_sW, _iY); _sec._drawings[3].Visible = _cVis
                _sY = _sY + _iY + 10
            end
        else for _, _s in pairs(_tb._sections) do _Undraw(_s._drawings); for _, _i in pairs(_s._items) do _Undraw(_i._drawings) end end end
    end

    if self._act_dd then
        local _dd = self._act_dd
        local _ddY = 0
        _dd._drawings[1].Position = _dd.pos; _dd._drawings[1].Visible = _cVis
        _dd._drawings[2].Position = _dd.pos; _dd._drawings[2].Visible = _cVis
        for _i, _c in ipairs(_dd.choices) do
            local _t = _dd._drawings[_i+2]; _t.Position = _dd.pos + Vector2.new(4, _ddY+2); _t.Visible = _cVis
            
            if _clk and self._IsMouseWithinBounds(_dd.pos + Vector2.new(0, _ddY), Vector2.new(_dd.w, 16)) then
                _dd.callback(_c); 
                _clk = false 
            end
            _ddY = _ddY + 16
        end
        _dd._drawings[1].Size = Vector2.new(_dd.w, _ddY+4); _dd._drawings[2].Size = Vector2.new(_dd.w, _ddY+4)
        
        if _clk and not self._IsMouseWithinBounds(_dd.pos, Vector2.new(_dd.w, _ddY)) then
             self:_RemoveDropdown()
        else
             _clk = false 
        end
    end
    
    self._tk = os.clock()
end

local _Workspace = game:GetService(_Str(87, 111, 114, 107, 115, 112, 97, 99, 101))
local _RocksBase = _Workspace:WaitForChild(_Str(82, 111, 99, 107, 115))
local _LivingF = _Workspace:WaitForChild(_Str(76, 105, 118, 105, 110, 103))

local _0x2B = {
    Active = false,
    MobFarm = false, 
    ClickDelay = 0.1,
    MovementSpeed = 0.1,
    SpeedCap = 3,
    SafeRadius = 20, 
    MobAvoidDist = 20,
    MobFarmRange = 1000, 
    AvoidStrength = 5.0,
    PlayerMiningDist = 10,
    DebugMode = false,
    CurrentRockFolder = _RocksBase:WaitForChild(_Str(73, 115, 108, 97, 110, 100, 50, 86, 111, 108, 99, 97, 110, 105, 99, 68, 101, 112, 116, 104, 115)),
    TargetRocks = {},
    TargetMobs = {},
}

local _CurStatus = _Str(73, 100, 108, 101)

local function _0x3C(_p1, _p2)
    if not _p1 or not _p2 then return 999999 end
    local _dx, _dy, _dz = _p1.X - _p2.X, _p1.Y - _p2.Y, _p1.Z - _p2.Z
    return math.sqrt(_dx*_dx + _dy*_dy + _dz*_dz)
end

local function _0x4D()
    local _t = {}
    local _s = {}
    if _0x2B.CurrentRockFolder then
        for _, _c in ipairs(_0x2B.CurrentRockFolder:GetChildren()) do
            if (_c:IsA(_Str(80, 97, 114, 116)) or _c:IsA(_Str(77, 101, 115, 104, 80, 97, 114, 116))) then
                local _m = _c:FindFirstChildOfClass(_Str(77, 111, 100, 101, 108))
                if _m and not _s[_m.Name] then
                    table.insert(_t, _m.Name)
                    _s[_m.Name] = true
                end
            end
        end
    end
    table.sort(_t)
    return _t
end

local function _0x5E()
    local _t = {}
    local _s = {}
    if _LivingF then
        for _, _c in ipairs(_LivingF:GetChildren()) do
            if _c:IsA(_Str(77, 111, 100, 101, 108)) then
                local _h = _c:FindFirstChild(_Str(72, 117, 109, 97, 110, 111, 105, 100))
                if _h and not _h:FindFirstChild(_Str(83, 116, 97, 116, 117, 115)) then
                    local _cl = string.gsub(_c.Name, _Str(37, 100, 43, 36), "") 
                    _cl = string.match(_cl, _Str(94, 37, 115, 42, 40, 46, 45, 41, 37, 115, 42, 36)) or _cl
                    
                    if not _s[_cl] then
                        table.insert(_t, _cl)
                        _s[_cl] = true
                    end
                end
            end
        end
    end
    table.sort(_t)
    return _t
end

local function _0x6F(_vM)
    if not _vM then return nil end
    local _iF = _vM:FindFirstChild(_Str(105, 110, 102, 111, 70, 114, 97, 109, 101))
    if _iF then
        local _fr = _iF:FindFirstChild(_Str(70, 114, 97, 109, 101))
        if _fr then
            local _hL = _fr:FindFirstChild(_Str(114, 111, 99, 107, 72, 80))
            if _hL then
                local _txt = _hL.Text
                local _num = tonumber(string.match(_txt, _Str(37, 100, 43)))
                return _num
            end
        end
    end
    return nil
end

local function _0x7G(_tP)
    local _ent = _LivingF:GetChildren()
    for _, _e in ipairs(_ent) do
        if _e:IsA(_Str(77, 111, 100, 101, 108)) and _e.Name ~= _LP.Name then
            local _r = _e:FindFirstChild(_Str(72, 117, 109, 97, 110, 111, 105, 100, 82, 111, 111, 116, 80, 97, 114, 116))
            if _r then
                local _d = _0x3C(_tP, _r.Position)
                if _e:GetAttribute(_Str(73, 115, 78, 112, 99)) == true then
                    if _d < _0x2B.SafeRadius then return false end
                else
                    if _d < _0x2B.PlayerMiningDist then return false end
                end
            end
        end
    end
    return true
end

local function _0x8H(_cP)
    local _tX, _tY = 0, 0
    local _ent = _LivingF:GetChildren()
    for _, _e in ipairs(_ent) do
        if _e:IsA(_Str(77, 111, 100, 101, 108)) and _e:GetAttribute(_Str(73, 115, 78, 112, 99)) == true then
            local _r = _e:FindFirstChild(_Str(72, 117, 109, 97, 110, 111, 105, 100, 82, 111, 111, 116, 80, 97, 114, 116))
            if _r then
                local _d = _0x3C(_cP, _r.Position)
                if _d < _0x2B.MobAvoidDist and _d > 0.1 then
                    local _pX, _pZ = _cP.X - _r.Position.X, _cP.Z - _r.Position.Z 
                    local _pD = math.sqrt(_pX*_pX + _pZ*_pZ)
                    local _w = (_0x2B.MobAvoidDist - _d) / _0x2B.MobAvoidDist
                    _tX = _tX + ((_pX / _pD) * _w)
                    _tY = _tY + ((_pZ / _pD) * _w)
                end
            end
        end
    end
    return _tX, _tY
end

local function _0x9I(_tC, _sO, _iA)
    local _c = _LP.Character; if not _c then return end
    local _hrp = _c:FindFirstChild(_Str(72, 117, 109, 97, 110, 111, 105, 100, 82, 111, 111, 116, 80, 97, 114, 116)); if not _hrp then return end
    local _cP = _hrp.Position
    local _cam = _Workspace.CurrentCamera 
    
    if _cam then
        pcall(function() 
            if Camera and Camera.lookAt then
                 Camera.lookAt(_cam.Position, _tC)
            elseif _cam.lookAt then
                 _cam:lookAt(_cam.Position, _tC)
            end
        end)
    end

    local _dx = _cP.X - _tC.X
    local _dz = _cP.Z - _tC.Z
    local _dTC = math.sqrt(_dx*_dx + _dz*_dz)
    
    local _STOP = _sO or 5 
    
    if _dTC > 0.1 then
        local _diX, _diZ = _dx / _dTC, _dz / _dTC
        local _deX = _tC.X + (_diX * _STOP)
        local _deZ = _tC.Z + (_diZ * _STOP)
        
        if _STOP <= 0.5 then
             _deX = _tC.X
             _deZ = _tC.Z
        end
        
        local _tPos = Vector3.new(_deX, _tC.Y, _deZ) 
        
        local _dTD = _0x3C(_tPos, _cP)
        
        local _aX, _aZ = 0, 0
        local _isA = false
        
        if not _iA then
            _aX, _aZ = _0x8H(_cP)
            _isA = (math.abs(_aX) > 0.01 or math.abs(_aZ) > 0.01)
        end

        if _dTD > 1 or _isA then
            local _mX = _deX - _cP.X
            local _mZ = _deZ - _cP.Z
            local _mD = math.sqrt(_mX*_mX + _mZ*_mZ)
            
            local _mdX = 0
            local _mdZ = 0
            
            if _mD > 0.01 then
                _mdX = _mX / _mD
                _mdZ = _mZ / _mD
            end
            
            local _fdX = _mdX + (_aX * _0x2B.AvoidStrength)
            local _fdZ = _mdZ + (_aZ * _0x2B.AvoidStrength)
            
            local _fD = math.sqrt(_fdX*_fdX + _fdZ*_fdZ)
            if _fD > 0 then _fdX = _fdX / _fD; _fdZ = _fdZ / _fD end
            
            local _mS = _dTD * _0x2B.MovementSpeed
            if _mS > _0x2B.SpeedCap then _mS = _0x2B.SpeedCap end
            
            if not _isA and _mS > _dTD then
                _mS = _dTD
            end

            local _nX = _cP.X + (_fdX * _mS)
            local _nZ = _cP.Z + (_fdZ * _mS)
            local _nY = _cP.Y + (_tC.Y - _cP.Y) * _0x2B.MovementSpeed
            
            _hrp.Position = Vector3.new(_nX, _nY, _nZ)
            _hrp.AssemblyLinearVelocity = Vector3.new(_fdX * 50, 0, _fdZ * 50)
        else
            _hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        end
    else
        _hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end
end

local function _0xAJ()
    if not _0x2B.CurrentRockFolder then return nil, nil end
    
    local _ch = _0x2B.CurrentRockFolder:GetChildren()
    local _cT, _cH, _minD = nil, nil, 9999999
    local _c = _LP.Character; if not _c then return nil, nil end
    local _hrp = _c:FindFirstChild(_Str(72, 117, 109, 97, 110, 111, 105, 100, 82, 111, 111, 116, 80, 97, 114, 116)); if not _hrp then return nil, nil end
    local _mP = _hrp.Position
    
    for _, _sL in ipairs(_ch) do
        local _vM = _sL:FindFirstChildOfClass(_Str(77, 111, 100, 101, 108))
        
        if _vM then
            local _rN = _vM.Name
            local _al = false
            if #_0x2B.TargetRocks == 0 then _al = true
            else
                for _, _t in ipairs(_0x2B.TargetRocks) do
                    if _t == _rN then _al = true; break end
                end
            end

            if not _al then continue end

            local _hb = _vM:FindFirstChild(_Str(72, 105, 116, 98, 111, 120))
            if _hb and _0x7G(_hb.Position) then
                local _d = _0x3C(_mP, _hb.Position)
                if _d < _minD then
                    _minD = _d
                    _cT = _sL
                    _cH = _hb
                end
            end
        end
    end
    return _cT, _cH
end

local function _0xBK()
    local _ch = _LivingF:GetChildren()
    local _cM, _cR, _minD = nil, nil, _0x2B.MobFarmRange
    
    local _c = _LP.Character; if not _c then return nil, nil end
    local _hrp = _c:FindFirstChild(_Str(72, 117, 109, 97, 110, 111, 105, 100, 82, 111, 111, 116, 80, 97, 114, 116)); if not _hrp then return nil, nil end
    local _mP = _hrp.Position

    local _cC = 0
    
    for _, _e in ipairs(_ch) do
        _cC = _cC + 1
        if _cC % 100 == 0 then task.wait() end
        
        if _e:IsA(_Str(77, 111, 100, 101, 108)) then
            local _h = _e:FindFirstChild(_Str(72, 117, 109, 97, 110, 111, 105, 100))
            if _h and not _h:FindFirstChild(_Str(83, 116, 97, 116, 117, 115)) then
                
                local _mA = false
                
                local _clE = string.gsub(_e.Name, _Str(37, 100, 43, 36), "")
                _clE = string.match(_clE, _Str(94, 37, 115, 42, 40, 46, 45, 41, 37, 115, 42, 36)) or _clE
                
                if #_0x2B.TargetMobs == 0 then _mA = true
                else
                    for _, _t in ipairs(_0x2B.TargetMobs) do
                        if _t == _clE then _mA = true; break end
                    end
                end
                
                if _mA then
                    local _r = _e:FindFirstChild(_Str(72, 117, 109, 97, 110, 111, 105, 100, 82, 111, 111, 116, 80, 97, 114, 116))
                    
                    if _r and _h.Health > 0 then
                        local _d = _0x3C(_mP, _r.Position)
                        if _d < _minD then
                            _minD = _d
                            _cM = _e
                            _cR = _r
                        end
                    end
                end
            end
        end
    end
    return _cM, _cR
end

spawn(function()
    while true do
        if _0x2B.Active then
            local _t, _h = _0xAJ()
            if _t and _h then
                local _vM = _h.Parent
                _CurStatus = _Str(77, 105, 110, 105, 110, 103, 32) .. _vM.Name
                
                local _aD = 5
                local _hL = _0x6F(_vM) or 99999
                local _tL = os.clock()
                
                while _0x2B.Active and _t.Parent do
                    local _c = _LP.Character
                    local _hrp = _c and _c:FindFirstChild(_Str(72, 117, 109, 97, 110, 111, 105, 100, 82, 111, 111, 116, 80, 97, 114, 116))
                    if _Gui._op then 
                        _CurStatus = _Str(80, 97, 117, 115, 101, 100, 32, 40, 77, 101, 110, 117, 32, 79, 112, 101, 110, 41)
                        if _hrp then _hrp.AssemblyLinearVelocity = Vector3.new(0,0,0) end
                        break 
                    end
                    
                    local _cH = _0x6F(_vM)
                    if _cH then
                        if _cH < _hL then
                            _hL = _cH
                            _tL = os.clock()
                        elseif (os.clock() - _tL) > 2 then
                            _aD = _aD - 1
                            if _aD < 3 then _aD = 6 end 
                            _tL = os.clock() 
                        end
                    end

                    if _h and _h.Parent then
                        if not _0x7G(_h.Position) then _CurStatus = _Str(85, 110, 115, 97, 102, 101, 33, 32, 82, 101, 108, 111, 99, 97, 116, 105, 110, 103, 46, 46, 46); break end
                        _0x9I(_h.Position, _aD, false) 
                    else break end
                    
                    pcall(function() mouse1click(); keypress(0x31); keyrelease(0x31) end)
                    wait(_0x2B.ClickDelay)
                end
                wait(0.1) 
            else
                _CurStatus = _Str(83, 101, 97, 114, 99, 104, 105, 110, 103, 32, 82, 111, 99, 107, 115, 46, 46, 46)
                local _c = _LP.Character
                if _c then
                    local _hrp = _c:FindFirstChild(_Str(72, 117, 109, 97, 110, 111, 105, 100, 82, 111, 111, 116, 80, 97, 114, 116))
                    if _hrp then
                        local _cP = _hrp.Position
                        local _aX, _aZ = _0x8H(_cP)
                        local _aM = math.sqrt(_aX*_aX + _aZ*_aZ)
                        if _aM > 0 then
                            local _mDX, _mDZ = _aX / _aM, _aZ / _aM
                            local _mS = _0x2B.SpeedCap 
                            local _nX, _nZ = _cP.X + (_mDX * _mS), _cP.Z + (_mDZ * _mS)
                            _hrp.Position = Vector3.new(_nX, _cP.Y, _nZ)
                            _hrp.AssemblyLinearVelocity = Vector3.new(_mDX * 50, 0, _mDZ * 50)
                        else
                            _hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        end
                    end
                end
                wait(0.1) 
            end
        elseif _0x2B.MobFarm then
            local _m, _mR = _0xBK()
            if _m and _mR then
                _CurStatus = _Str(75, 105, 108, 108, 105, 110, 103, 32) .. _m.Name
                
                while _0x2B.MobFarm and _m.Parent and _m:FindFirstChild(_Str(72, 117, 109, 97, 110, 111, 105, 100)) and _m.Humanoid.Health > 0 do
                    local _c = _LP.Character
                    local _hrp = _c and _c:FindFirstChild(_Str(72, 117, 109, 97, 110, 111, 105, 100, 82, 111, 111, 116, 80, 97, 114, 116))
                    
                    if _Gui._op then 
                        _CurStatus = _Str(80, 97, 117, 115, 101, 100, 32, 40, 77, 101, 110, 117, 32, 79, 112, 101, 110, 41)
                        if _hrp then _hrp.AssemblyLinearVelocity = Vector3.new(0,0,0) end
                        break 
                    end

                    if _mR then
                        _0x9I(_mR.Position, 0, true)
                    end

                    pcall(function() 
                        mouse1click() 
                        keypress(0x32); keyrelease(0x32) 
                    end)
                    
                    wait(_0x2B.ClickDelay)
                end
            else
                _CurStatus = _Str(83, 101, 97, 114, 99, 104, 105, 110, 103, 32, 77, 111, 98, 115, 46, 46, 46)
            end
            wait(0.1)
        else
            _CurStatus = _Str(80, 97, 117, 115, 101, 100)
            wait(0.2)
        end
        wait(0.05) 
    end
end)

local function _GetS() return _CurStatus end
_Gui = _0x1A.new(_Str(77, 97, 116, 99, 104, 97, 32, 77, 105, 110, 101, 114), Vector2.new(400, 420), {_GetS})

local _locs = {}
for _, _f in ipairs(_RocksBase:GetChildren()) do table.insert(_locs, _f.Name) end

local _mT = _Gui:Tab(_Str(77, 97, 105, 110))
local _mS = _Gui:Section(_mT, _Str(67, 111, 110, 116, 114, 111, 108, 115))
_Gui:Checkbox(_mT, _mS, _Str(69, 110, 97, 98, 108, 101, 32, 77, 105, 110, 101, 114), false, function(_s) _0x2B.Active = _s end)
_Gui:Checkbox(_mT, _mS, _Str(69, 110, 97, 98, 108, 101, 32, 77, 111, 98, 32, 70, 97, 114, 109), false, function(_s) _0x2B.MobFarm = _s end)

local _dI 
_dI = _Gui:DualChoice(_mT, _mS, 
    _Str(84, 97, 114, 103, 101, 116, 115), {}, function(_v) _0x2B.TargetRocks = _v end, _0x4D(),
    _Str(76, 111, 99, 97, 116, 105, 111, 110), _Str(73, 115, 108, 97, 110, 100, 50, 86, 111, 108, 99, 97, 110, 105, 99, 68, 101, 112, 116, 104, 115), function(_v)
        local _nF = _RocksBase:FindFirstChild(_v)
        if _nF then
            _0x2B.CurrentRockFolder = _nF
            local _nR = _0x4D()
            if _dI then
                _dI.ch1 = _nR 
                _dI.v1 = {} 
                _0x2B.TargetRocks = {} 
                print(_Str(76, 111, 99, 97, 116, 105, 111, 110, 32, 117, 112, 100, 97, 116, 101, 100, 58, 32) .. _v)
            end
        end
    end, _locs
)

local _mDI
_mDI = _Gui:DualChoice(_mT, _mS,
    _Str(77, 111, 98, 32, 84, 97, 114, 103, 101, 116, 115), {}, function(_v) _0x2B.TargetMobs = _v end, _0x5E(),
    _Str(82, 101, 102, 114, 101, 115, 104, 32, 77, 111, 98, 115), _Str(67, 108, 105, 99, 107), function() 
        if _mDI then
            _mDI.ch1 = _0x5E() 
            print(_Str(77, 111, 98, 32, 108, 105, 115, 116, 32, 114, 101, 102, 114, 101, 115, 104, 101, 100))
        end
    end, {_Str(67, 108, 105, 99, 107)} 
)

local _sT = _Gui:Tab(_Str(83, 101, 116, 116, 105, 110, 103, 115))
local _mvS = _Gui:Section(_sT, _Str(77, 111, 118, 101, 109, 101, 110, 116))
_Gui:Slider(_sT, _mvS, _Str(83, 112, 101, 101, 100, 32, 67, 97, 112), _0x2B.SpeedCap, function(_v) _0x2B.SpeedCap = _v end, 1, 10, 1, _Str(32, 115, 116, 117, 100, 115))
_Gui:Slider(_sT, _mvS, _Str(83, 109, 111, 111, 116, 104, 110, 101, 115, 115), _0x2B.MovementSpeed, function(_v) _0x2B.MovementSpeed = _v end, 0.01, 1, 0.01, '')
_Gui:Slider(_sT, _mvS, _Str(67, 108, 105, 99, 107, 32, 68, 101, 108, 97, 121), _0x2B.ClickDelay, function(_v) _0x2B.ClickDelay = _v end, 0.01, 1, 0.01, _Str(115))

local _sfT = _Gui:Tab(_Str(83, 97, 102, 101, 116, 121))
local _sfS = _Gui:Section(_sfT, _Str(65, 118, 111, 105, 100, 97, 110, 99, 101))
_Gui:Slider(_sfT, _sfS, _Str(77, 111, 98, 32, 83, 97, 102, 101, 32, 82, 97, 100, 105, 117, 115), _0x2B.SafeRadius, function(_v) _0x2B.SafeRadius = _v end, 10, 100, 5, _Str(32, 115, 116, 117, 100, 115))
_Gui:Slider(_sfT, _sfS, _Str(80, 108, 97, 121, 101, 114, 32, 68, 105, 115, 116), _0x2B.PlayerMiningDist, function(_v) _0x2B.PlayerMiningDist = _v end, 5, 50, 5, _Str(32, 115, 116, 117, 100, 115))
_Gui:Slider(_sfT, _sfS, _Str(77, 111, 98, 32, 69, 118, 97, 100, 101, 32, 68, 105, 115, 116), _0x2B.MobAvoidDist, function(_v) _0x2B.MobAvoidDist = _v end, 10, 50, 5, _Str(32, 115, 116, 117, 100, 115))
_Gui:Slider(_sfT, _sfS, _Str(69, 118, 97, 100, 101, 32, 70, 111, 114, 99, 101), _0x2B.AvoidStrength, function(_v) _0x2B.AvoidStrength = _v end, 1, 10, 0.5, '')
_Gui:Slider(_sfT, _sfS, _Str(77, 111, 98, 32, 70, 97, 114, 109, 32, 82, 97, 110, 103, 101), _0x2B.MobFarmRange, function(_v) _0x2B.MobFarmRange = _v end, 100, 5000, 100, _Str(32, 115, 116, 117, 100, 115))

while true do
    if iskeypressed(0x23) then 
        _Gui:ToggleMenu(not _Gui._op)
        while iskeypressed(0x23) do wait(0.05) end 
    end
    _Gui:Step()
    wait(0.005)
end
