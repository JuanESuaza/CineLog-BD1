import { Component, Input, Output, EventEmitter, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { AuthService } from '../../services/auth.service';
import { ToastService } from '../../services/toast.service';

@Component({
  selector: 'app-detail-modal',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './detail-modal.component.html',
  styleUrls: ['./detail-modal.component.scss']
})
export class DetailModalComponent implements OnInit {
  @Input() contenidoId!: number;
  @Output() closed = new EventEmitter<void>();

  contenido = signal<any>(null);
  loading = signal(true);
  activeTab = signal<string>('info');
  selectedTemporada = signal<any>(null);
  episodios = signal<any[]>([]);
  loadingEpisodios = signal(false);
  miCalificacion = signal<any>(null);
  calificacionForm = { puntuacion: 0, resenia: '' };
  calificandoLoading = signal(false);
  hoverStar = signal(0);
  miFinal = signal<any>(null);
  finalForm = { texto_final: '' };
  finalLoading = signal(false);
  todosFinales = signal<any[]>([]);
  misListas = signal<any[]>([]);
  listaSeleccionada: any = null;
  stars_list = [1,2,3,4,5,6,7,8,9,10];

  constructor(private api: ApiService, public auth: AuthService, private toast: ToastService) {}

  ngOnInit() {
    this.loadContenido();
    if (this.auth.isLoggedIn()) { this.loadMiCalificacion(); this.loadMiFinal(); this.loadMisListas(); }
    this.loadTodosFinales();
  }

  loadContenido() {
    this.api.getContenido(this.contenidoId).subscribe({
      next: (data: any) => { this.contenido.set(data); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }
  loadMiCalificacion() {
    this.api.getCalificacion(this.contenidoId).subscribe({
      next: (data: any) => { if (data) { this.miCalificacion.set(data); this.calificacionForm = { puntuacion: data.puntuacion, resenia: data.resenia || '' }; } }
    });
  }
  loadMiFinal() {
    this.api.getFinal(this.contenidoId).subscribe({
      next: (data: any) => { if (data) { this.miFinal.set(data); this.finalForm.texto_final = data.texto_final; } }
    });
  }
  loadTodosFinales() { this.api.getTodosFinales(this.contenidoId).subscribe({ next: (data: any) => this.todosFinales.set(data) }); }
  loadMisListas() { this.api.getListas().subscribe({ next: (data: any) => this.misListas.set(data) }); }

  loadEpisodios(temporada: any) {
    if (this.selectedTemporada()?.id_temporada === temporada.id_temporada) { this.selectedTemporada.set(null); return; }
    this.selectedTemporada.set(temporada);
    this.loadingEpisodios.set(true);
    this.api.getEpisodios(temporada.id_temporada).subscribe({ next: (data: any) => { this.episodios.set(data); this.loadingEpisodios.set(false); } });
  }

  guardarCalificacion() {
    if (!this.calificacionForm.puntuacion) { this.toast.show('Selecciona una puntuacion', 'error'); return; }
    this.calificandoLoading.set(true);
    this.api.guardarCalificacion({ id_contenido: this.contenidoId, ...this.calificacionForm }).subscribe({
      next: () => { this.toast.show('Calificacion guardada!'); this.calificandoLoading.set(false); this.loadContenido(); },
      error: () => { this.toast.show('Error al guardar', 'error'); this.calificandoLoading.set(false); }
    });
  }

  guardarFinal() {
    if (!this.finalForm.texto_final.trim()) { this.toast.show('Escribe tu final alternativo', 'error'); return; }
    this.finalLoading.set(true);
    this.api.guardarFinal({ id_contenido: this.contenidoId, ...this.finalForm }).subscribe({
      next: () => { this.toast.show('Final guardado!'); this.finalLoading.set(false); this.miFinal.set({ texto_final: this.finalForm.texto_final }); this.loadTodosFinales(); },
      error: () => { this.toast.show('Error al guardar', 'error'); this.finalLoading.set(false); }
    });
  }

  agregarALista() {
    if (!this.listaSeleccionada) { this.toast.show('Selecciona una lista', 'error'); return; }
    this.api.agregarALista(Number(this.listaSeleccionada), this.contenidoId).subscribe({
      next: () => this.toast.show('Agregado a la lista!'),
      error: () => this.toast.show('Error al agregar', 'error')
    });
  }

  setTab(tab: string) { this.activeTab.set(tab); }
  setHoverStar(n: number) { this.hoverStar.set(n); }
  clearHover() { this.hoverStar.set(0); }
  setStar(n: number) { this.calificacionForm.puntuacion = n; this.hoverStar.set(0); }
  getStarClass(n: number): string { return n <= (this.hoverStar() || this.calificacionForm.puntuacion) ? 'star-filled' : 'star-empty'; }
  starsText(n: number): string { if (!n) return ''; return ('★'.repeat(Math.round(n/2))) + ('☆'.repeat(5 - Math.round(n/2))); }
  getScore(): number { return this.hoverStar() || this.calificacionForm.puntuacion || 0; }
  close() { this.closed.emit(); }
  onOverlayClick(e: MouseEvent) { if ((e.target as HTMLElement).classList.contains('modal-overlay')) this.close(); }
}
