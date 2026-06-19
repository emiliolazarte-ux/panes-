(function () {
  const fmt = (n) => '$' + (Number(n) || 0).toLocaleString('es-AR', { minimumFractionDigits: 0, maximumFractionDigits: 2 });
  const todayStr = () => new Date().toISOString().slice(0, 10);
  const fmtDate = (d) => { if (!d) return ''; const [y, m, day] = d.split('-'); return `${day}/${m}/${y}`; };
  const escapeHtml = (str) => String(str).replace(/[&<>"']/g, (m) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[m]));

  let supabase = null;
  let orders = [], expenses = [], incomes = [];
  let editingId = null;
  let orderFilter = 'todos';
  let searchTerm = '';

  // ---------- Config (Supabase credentials, stored locally on this device) ----------
  const cfgOverlay = document.getElementById('config-overlay');
  const cfgUrl = document.getElementById('cfg-url');
  const cfgKey = document.getElementById('cfg-key');
  const cfgStatus = document.getElementById('cfg-status');
  const cfgCancel = document.getElementById('cfg-cancel');

  function getStoredConfig() {
    return {
      url: localStorage.getItem('juachi_supabase_url') || '',
      key: localStorage.getItem('juachi_supabase_key') || ''
    };
  }

  function openConfig(allowCancel) {
    const cfg = getStoredConfig();
    cfgUrl.value = cfg.url;
    cfgKey.value = cfg.key;
    cfgStatus.textContent = '';
    cfgStatus.className = 'status-msg';
    cfgCancel.classList.toggle('hidden', !allowCancel);
    cfgOverlay.classList.remove('hidden');
  }
  function closeConfig() { cfgOverlay.classList.add('hidden'); }

  document.getElementById('open-config').addEventListener('click', () => openConfig(true));
  cfgCancel.addEventListener('click', closeConfig);

  document.getElementById('cfg-save').addEventListener('click', async () => {
    const url = cfgUrl.value.trim();
    const key = cfgKey.value.trim();
    if (!url || !key) {
      cfgStatus.textContent = 'Completá los dos campos.';
      cfgStatus.className = 'status-msg error';
      return;
    }
    cfgStatus.textContent = 'Conectando...';
    cfgStatus.className = 'status-msg';

    try {
      const client = window.supabase.createClient(url, key);
      const { error } = await client.from('orders').select('id').limit(1);
      if (error) throw error;

      localStorage.setItem('juachi_supabase_url', url);
      localStorage.setItem('juachi_supabase_key', key);
      supabase = client;
      cfgStatus.textContent = '¡Conectado!';
      cfgStatus.className = 'status-msg ok';
      setTimeout(async () => { closeConfig(); await loadAll(); }, 500);
    } catch (e) {
      cfgStatus.textContent = 'No se pudo conectar. Revisá la URL, la clave, y que hayas corrido el schema.sql en Supabase.';
      cfgStatus.className = 'status-msg error';
    }
  });

  async function initSupabase() {
    const cfg = getStoredConfig();
    if (!cfg.url || !cfg.key) {
      openConfig(false);
      return false;
    }
    supabase = window.supabase.createClient(cfg.url, cfg.key);
    return true;
  }

  // ---------- Tabs ----------
  document.querySelectorAll('.tab-btn').forEach((btn) => {
    btn.addEventListener('click', () => {
      document.querySelectorAll('.tab-btn').forEach((b) => b.classList.remove('active'));
      btn.classList.add('active');
      const tab = btn.dataset.tab;
      document.getElementById('tab-pedidos').classList.toggle('hidden', tab !== 'pedidos');
      document.getElementById('tab-finanzas').classList.toggle('hidden', tab !== 'finanzas');
    });
  });

  document.querySelectorAll('.finance-subtabs .chip').forEach((chip) => {
    chip.addEventListener('click', () => {
      document.querySelectorAll('.finance-subtabs .chip').forEach((c) => c.classList.remove('active'));
      chip.classList.add('active');
      const fin = chip.dataset.fin;
      document.getElementById('fin-gastos').classList.toggle('hidden', fin !== 'gastos');
      document.getElementById('fin-ingresos').classList.toggle('hidden', fin !== 'ingresos');
    });
  });

  // ---------- Data loading ----------
  async function loadAll() {
    if (!supabase) return;
    const [{ data: o, error: oe }, { data: g, error: ge }, { data: i, error: ie }] = await Promise.all([
      supabase.from('orders').select('*').order('fecha', { ascending: true }),
      supabase.from('expenses').select('*').order('fecha', { ascending: false }),
      supabase.from('incomes').select('*').order('fecha', { ascending: false })
    ]);
    if (oe || ge || ie) {
      console.error(oe, ge, ie);
      return;
    }
    orders = o || [];
    expenses = g || [];
    incomes = i || [];
    renderOrders();
    renderFinance();
  }

  // ---------- Pedidos: form ----------
  const formPedido = document.getElementById('form-pedido');
  const pCancelBtn = document.getElementById('p-cancel-btn');
  const pSubmitBtn = document.getElementById('p-submit-btn');
  document.getElementById('p-fecha').value = todayStr();

  formPedido.addEventListener('submit', async (e) => {
    e.preventDefault();
    if (!supabase) return;
    const cliente = document.getElementById('p-cliente').value.trim();
    const pan = document.getElementById('p-pan').value.trim();
    const cantidad = parseFloat(document.getElementById('p-cantidad').value);
    const precio = parseFloat(document.getElementById('p-precio').value) || 0;
    const fecha = document.getElementById('p-fecha').value;
    const notas = document.getElementById('p-notas').value.trim();
    if (!cliente || !pan || !cantidad || !fecha) return;

    if (editingId) {
      const { error } = await supabase.from('orders')
        .update({ cliente, pan, cantidad, precio, fecha, notas })
        .eq('id', editingId);
      if (error) { console.error(error); return; }
      editingId = null;
      pSubmitBtn.textContent = 'Agregar pedido';
      pCancelBtn.classList.add('hidden');
    } else {
      const { error } = await supabase.from('orders')
        .insert({ cliente, pan, cantidad, precio, fecha, notas, estado: 'pendiente', facturado: false });
      if (error) { console.error(error); return; }
    }
    formPedido.reset();
    document.getElementById('p-fecha').value = todayStr();
    await loadAll();
  });

  pCancelBtn.addEventListener('click', () => {
    editingId = null;
    formPedido.reset();
    document.getElementById('p-fecha').value = todayStr();
    pSubmitBtn.textContent = 'Agregar pedido';
    pCancelBtn.classList.add('hidden');
  });

  document.querySelectorAll('.filter-row .chip').forEach((chip) => {
    chip.addEventListener('click', () => {
      document.querySelectorAll('.filter-row .chip').forEach((c) => c.classList.remove('active'));
      chip.classList.add('active');
      orderFilter = chip.dataset.filter;
      renderOrders();
    });
  });

  document.getElementById('p-buscar').addEventListener('input', (e) => {
    searchTerm = e.target.value.trim().toLowerCase();
    renderOrders();
  });

  function renderOrders() {
    const list = document.getElementById('pedidos-list');
    let items = [...orders];
    if (orderFilter !== 'todos') items = items.filter((o) => o.estado === orderFilter);
    if (searchTerm) items = items.filter((o) => o.cliente.toLowerCase().includes(searchTerm));
    items.sort((a, b) => a.fecha.localeCompare(b.fecha));

    if (items.length === 0) {
      list.innerHTML = `<div class="empty">Todavía no hay pedidos acá. Agregá el primero arriba 🥐</div>`;
      return;
    }

    list.innerHTML = items.map((o) => {
      const total = o.precio ? o.precio * o.cantidad : null;
      return `
      <div class="ticket" data-id="${o.id}">
        <div class="ticket-top">
          <div>
            <div class="ticket-client">${escapeHtml(o.cliente)}</div>
            <div class="ticket-pan">${o.cantidad} × ${escapeHtml(o.pan)}</div>
          </div>
          <span class="stamp ${o.estado}" data-action="toggle-estado">${o.estado === 'pendiente' ? 'Pendiente' : 'Entregado'}</span>
        </div>
        <div class="ticket-meta">
          <span>📅 Entrega: ${fmtDate(o.fecha)}</span>
          ${total !== null ? `<span class="ticket-total">${fmt(total)}</span>` : ''}
        </div>
        ${o.notas ? `<div class="ticket-notes">"${escapeHtml(o.notas)}"</div>` : ''}
        <div class="ticket-actions">
          <button class="link-btn" data-action="edit">Editar</button>
          <button class="btn-danger" data-action="delete">Eliminar</button>
          ${o.estado === 'entregado' && total !== null && !o.facturado ? `<button class="btn-sage" data-action="registrar-venta" style="font-size:12px;padding:6px 10px;">Registrar venta en Finanzas</button>` : ''}
          ${o.facturado ? `<span class="registrada-tag">✓ venta registrada</span>` : ''}
        </div>
      </div>`;
    }).join('');

    list.querySelectorAll('.ticket').forEach((card) => {
      const id = card.dataset.id;
      const ord = orders.find((o) => o.id === id);

      card.querySelector('[data-action="toggle-estado"]').addEventListener('click', async () => {
        const nuevoEstado = ord.estado === 'pendiente' ? 'entregado' : 'pendiente';
        const { error } = await supabase.from('orders').update({ estado: nuevoEstado }).eq('id', id);
        if (!error) await loadAll();
      });

      card.querySelector('[data-action="delete"]').addEventListener('click', async () => {
        const { error } = await supabase.from('orders').delete().eq('id', id);
        if (!error) await loadAll();
      });

      card.querySelector('[data-action="edit"]').addEventListener('click', () => {
        editingId = id;
        document.getElementById('p-cliente').value = ord.cliente;
        document.getElementById('p-pan').value = ord.pan;
        document.getElementById('p-cantidad').value = ord.cantidad;
        document.getElementById('p-precio').value = ord.precio || '';
        document.getElementById('p-fecha').value = ord.fecha;
        document.getElementById('p-notas').value = ord.notas || '';
        pSubmitBtn.textContent = 'Guardar cambios';
        pCancelBtn.classList.remove('hidden');
        document.getElementById('tab-pedidos').scrollIntoView({ behavior: 'smooth', block: 'start' });
      });

      const ventaBtn = card.querySelector('[data-action="registrar-venta"]');
      if (ventaBtn) {
        ventaBtn.addEventListener('click', async () => {
          const total = ord.precio * ord.cantidad;
          const { error: e1 } = await supabase.from('incomes').insert({
            pan: ord.pan, cantidad: ord.cantidad, precio: ord.precio, total, fecha: ord.fecha
          });
          if (e1) { console.error(e1); return; }
          const { error: e2 } = await supabase.from('orders').update({ facturado: true }).eq('id', id);
          if (e2) { console.error(e2); return; }
          await loadAll();
        });
      }
    });

    renderPedidosBreakdown();
  }

  function renderPedidosBreakdown() {
    const div = document.getElementById('pedidos-breakdown');
    if (!div) return;
    const byPan = {};
    orders.forEach((o) => {
      const key = o.pan.trim();
      if (!byPan[key]) byPan[key] = { pedidos: 0, cantidad: 0 };
      byPan[key].pedidos += 1;
      byPan[key].cantidad += Number(o.cantidad);
    });
    const keys = Object.keys(byPan).sort((a, b) => byPan[b].cantidad - byPan[a].cantidad);
    if (keys.length === 0) { div.innerHTML = ''; return; }
    div.innerHTML = keys.map((k) => `
      <div class="pan-chip">
        <div class="pname">${escapeHtml(k)}</div>
        <div class="pcount">${byPan[k].pedidos} pedido${byPan[k].pedidos !== 1 ? 's' : ''} · ${byPan[k].cantidad} panes</div>
      </div>`).join('');
  }

  // ---------- Gastos ----------
  const formGasto = document.getElementById('form-gasto');
  document.getElementById('g-fecha').value = todayStr();

  formGasto.addEventListener('submit', async (e) => {
    e.preventDefault();
    if (!supabase) return;
    const insumo = document.getElementById('g-insumo').value.trim();
    const monto = parseFloat(document.getElementById('g-monto').value);
    const fecha = document.getElementById('g-fecha').value;
    if (!insumo || !monto || !fecha) return;
    const { error } = await supabase.from('expenses').insert({ insumo, monto, fecha });
    if (error) { console.error(error); return; }
    formGasto.reset();
    document.getElementById('g-fecha').value = todayStr();
    await loadAll();
  });

  // ---------- Ingresos ----------
  const formIngreso = document.getElementById('form-ingreso');
  document.getElementById('i-fecha').value = todayStr();

  formIngreso.addEventListener('submit', async (e) => {
    e.preventDefault();
    if (!supabase) return;
    const pan = document.getElementById('i-pan').value.trim();
    const cantidad = parseFloat(document.getElementById('i-cantidad').value);
    const precio = parseFloat(document.getElementById('i-precio').value);
    const fecha = document.getElementById('i-fecha').value;
    if (!pan || !cantidad || !precio || !fecha) return;
    const { error } = await supabase.from('incomes').insert({ pan, cantidad, precio, fecha, total: cantidad * precio });
    if (error) { console.error(error); return; }
    formIngreso.reset();
    document.getElementById('i-fecha').value = todayStr();
    await loadAll();
  });

  function renderFinance() {
    const gastosList = document.getElementById('gastos-list');
    const sortedGastos = [...expenses].sort((a, b) => b.fecha.localeCompare(a.fecha));
    if (sortedGastos.length === 0) {
      gastosList.innerHTML = `<div class="empty">Sin gastos registrados todavía.</div>`;
    } else {
      gastosList.innerHTML = `
        <table class="ledger">
          <thead><tr><th>Fecha</th><th>Insumo</th><th class="num">Monto</th><th></th></tr></thead>
          <tbody>
            ${sortedGastos.map((g) => `
              <tr data-id="${g.id}">
                <td>${fmtDate(g.fecha)}</td>
                <td>${escapeHtml(g.insumo)}</td>
                <td class="num">${fmt(g.monto)}</td>
                <td><button class="row-del" data-del-gasto="${g.id}">✕</button></td>
              </tr>`).join('')}
          </tbody>
        </table>`;
      gastosList.querySelectorAll('[data-del-gasto]').forEach((btn) => {
        btn.addEventListener('click', async () => {
          const { error } = await supabase.from('expenses').delete().eq('id', btn.dataset.delGasto);
          if (!error) await loadAll();
        });
      });
    }

    const ingresosList = document.getElementById('ingresos-list');
    const sortedIngresos = [...incomes].sort((a, b) => b.fecha.localeCompare(a.fecha));
    if (sortedIngresos.length === 0) {
      ingresosList.innerHTML = `<div class="empty">Sin ventas registradas todavía.</div>`;
    } else {
      ingresosList.innerHTML = `
        <table class="ledger">
          <thead><tr><th>Fecha</th><th>Pan</th><th class="num">Cant.</th><th class="num">Total</th><th></th></tr></thead>
          <tbody>
            ${sortedIngresos.map((i) => `
              <tr data-id="${i.id}">
                <td>${fmtDate(i.fecha)}</td>
                <td>${escapeHtml(i.pan)}</td>
                <td class="num">${i.cantidad}</td>
                <td class="num">${fmt(i.total)}</td>
                <td><button class="row-del" data-del-ingreso="${i.id}">✕</button></td>
              </tr>`).join('')}
          </tbody>
        </table>`;
      ingresosList.querySelectorAll('[data-del-ingreso]').forEach((btn) => {
        btn.addEventListener('click', async () => {
          const { error } = await supabase.from('incomes').delete().eq('id', btn.dataset.delIngreso);
          if (!error) await loadAll();
        });
      });
    }

    const breakdownBody = document.getElementById('breakdown-body');
    const byPan = {};
    incomes.forEach((i) => {
      const key = i.pan.trim();
      if (!byPan[key]) byPan[key] = { cantidad: 0, total: 0 };
      byPan[key].cantidad += Number(i.cantidad);
      byPan[key].total += Number(i.total);
    });
    const panKeys = Object.keys(byPan).sort((a, b) => byPan[b].total - byPan[a].total);
    breakdownBody.innerHTML = panKeys.length === 0
      ? `<tr><td colspan="3" style="color:var(--ink-soft);">Sin datos todavía.</td></tr>`
      : panKeys.map((k) => `
        <tr>
          <td>${escapeHtml(k)}</td>
          <td class="num">${byPan[k].cantidad}</td>
          <td class="num">${fmt(byPan[k].total)}</td>
        </tr>`).join('');

    const totalGastos = expenses.reduce((s, g) => s + Number(g.monto), 0);
    const totalIngresos = incomes.reduce((s, i) => s + Number(i.total), 0);
    document.getElementById('sum-gastos').textContent = fmt(totalGastos);
    document.getElementById('sum-ingresos').textContent = fmt(totalIngresos);
    document.getElementById('sum-balance').textContent = fmt(totalIngresos - totalGastos);
  }

  // ---------- Boot ----------
  (async () => {
    const ready = await initSupabase();
    if (ready) await loadAll();
  })();

  if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
      navigator.serviceWorker.register('sw.js').catch(() => {});
    });
  }
})();
