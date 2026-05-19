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
  calificacionForm = {
    puntuacion: 0,
    resenia: ''
  };
  calificandoLoading = signal(false);
  hoverStar = signal(0);

  miFinal = signal<any>(null);
  finalForm = {
    texto_final: ''
  };
  finalLoading = signal(false);
  todosFinales = signal<any[]>([]);

  misListas = signal<any[]>([]);
  listaSeleccionada: any = null;

  stars_list = [1,2,3,4,5,6,7,8,9,10];

  constructor(
    private api: ApiService,
    public auth: AuthService,
    private toast: ToastService
  ) {}

  ngOnInit() {
    this.loadContenido();

    if (this.auth.isLoggedIn()) {
      this.loadMisListas();
      this.loadMiFinal();
    }

    this.loadTodosFinales();
  }

  loadContenido() {
    this.loading.set(true);

    this.api.getContenido(this.contenidoId).subscribe({
      next: (data: any) => {
        this.contenido.set(data);
        this.loading.set(false);

        // Después de cargar el contenido, cargamos sus calificaciones.
        this.loadCalificaciones();
      },
      error: (err) => {
        console.error('Error cargando contenido:', err);
        this.loading.set(false);
      }
    });
  }

  loadCalificaciones() {
    this.api.getCalificacion(this.contenidoId).subscribe({
      next: (data: any) => {
        const calificaciones = Array.isArray(data) ? data : [];

        const contenidoActual = this.contenido();

        if (contenidoActual) {
          this.contenido.set({
            ...contenidoActual,
            calificaciones: calificaciones
          });
        }

        // Intentar detectar si una calificación es del usuario actual.
        const usuarioActual = localStorage.getItem('cl_user');
        let nombreUsuario = '';

        if (usuarioActual) {
          try {
            nombreUsuario = JSON.parse(usuarioActual).nombre_usuario || '';
          } catch {
            nombreUsuario = '';
          }
        }

        const mia = calificaciones.find((c: any) => c.nombre_usuario === nombreUsuario);

        if (mia) {
          this.miCalificacion.set(mia);
          this.calificacionForm = {
            puntuacion: Number(mia.puntuacion),
            resenia: mia.resenia || mia.resena || ''
          };
        }
      },
      error: (err) => {
        console.error('Error cargando calificaciones:', err);
      }
    });
  }

  loadMiFinal() {
    this.api.getFinal(this.contenidoId).subscribe({
      next: (data: any) => {
        if (data && data.texto_final) {
          this.miFinal.set(data);
          this.finalForm.texto_final = data.texto_final;
        } else {
          this.miFinal.set(null);
        }
      },
      error: (err) => {
        console.error('Error cargando mi final:', err);
        this.miFinal.set(null);
      }
    });
  }

  loadTodosFinales() {
    this.api.getTodosFinales(this.contenidoId).subscribe({
      next: (data: any) => {
        this.todosFinales.set(Array.isArray(data) ? data : []);
      },
      error: (err) => {
        console.error('Error cargando finales:', err);
        this.todosFinales.set([]);
      }
    });
  }

  loadMisListas() {
    this.api.getListas().subscribe({
      next: (data: any) => this.misListas.set(Array.isArray(data) ? data : []),
      error: (err) => console.error('Error cargando listas:', err)
    });
  }

  loadEpisodios(temporada: any) {
    if (this.selectedTemporada()?.id_temporada === temporada.id_temporada) {
      this.selectedTemporada.set(null);
      return;
    }

    this.selectedTemporada.set(temporada);
    this.loadingEpisodios.set(true);

    this.api.getEpisodios(temporada.id_temporada).subscribe({
      next: (data: any) => {
        this.episodios.set(Array.isArray(data) ? data : []);
        this.loadingEpisodios.set(false);
      },
      error: (err) => {
        console.error('Error cargando episodios:', err);
        this.loadingEpisodios.set(false);
      }
    });
  }

  guardarCalificacion() {
    if (!this.calificacionForm.puntuacion) {
      this.toast.show('Selecciona una puntuacion', 'error');
      return;
    }

    this.calificandoLoading.set(true);

    const body = {
      id_contenido: Number(this.contenidoId),
      puntuacion: Number(this.calificacionForm.puntuacion),
      resenia: this.calificacionForm.resenia || '',
      resena: this.calificacionForm.resenia || ''
    };

    console.log('Enviando calificacion:', body);

    this.api.guardarCalificacion(body).subscribe({
      next: (data: any) => {
        console.log('Calificacion guardada:', data);

        this.toast.show('Calificacion guardada!');
        this.calificandoLoading.set(false);

        this.loadContenido();
        this.loadCalificaciones();
      },
      error: (err) => {
        console.error('Error al guardar calificacion:', err);
        console.error('Respuesta backend:', err.error);

        this.toast.show(err.error?.message || 'Error al guardar calificacion', 'error');
        this.calificandoLoading.set(false);
      }
    });
  }

  guardarFinal() {
    if (!this.finalForm.texto_final || !this.finalForm.texto_final.trim()) {
      this.toast.show('Escribe tu final alternativo', 'error');
      return;
    }

    this.finalLoading.set(true);

    const texto = this.finalForm.texto_final.trim();

    const body = {
      id_contenido: Number(this.contenidoId),
      texto_final: texto,
      textoFinal: texto,
      texto: texto
    };

    console.log('Enviando final:', body);

    this.api.guardarFinal(body).subscribe({
      next: (data: any) => {
        console.log('Final guardado:', data);

        this.toast.show('Final guardado!');
        this.finalLoading.set(false);

        this.miFinal.set({
          texto_final: texto
        });

        this.loadMiFinal();
        this.loadTodosFinales();
      },
      error: (err) => {
        console.error('Error al guardar final:', err);
        console.error('Respuesta backend:', err.error);

        this.toast.show(err.error?.message || 'Error al guardar final', 'error');
        this.finalLoading.set(false);
      }
    });
  }

  agregarALista() {
    if (!this.listaSeleccionada) {
      this.toast.show('Selecciona una lista', 'error');
      return;
    }

    this.api.agregarALista(Number(this.listaSeleccionada), this.contenidoId).subscribe({
      next: () => this.toast.show('Agregado a la lista!'),
      error: (err) => {
        console.error('Error al agregar a lista:', err);
        this.toast.show('Error al agregar', 'error');
      }
    });
  }

  setTab(tab: string) {
    this.activeTab.set(tab);

    if (tab === 'calificaciones') {
      this.loadCalificaciones();
    }

    if (tab === 'finales') {
      this.loadMiFinal();
      this.loadTodosFinales();
    }
  }

  setHoverStar(n: number) {
    this.hoverStar.set(n);
  }

  clearHover() {
    this.hoverStar.set(0);
  }

  setStar(n: number) {
    this.calificacionForm.puntuacion = n;
    this.hoverStar.set(0);
  }

  getStarClass(n: number): string {
    return n <= (this.hoverStar() || this.calificacionForm.puntuacion)
      ? 'star-filled'
      : 'star-empty';
  }

  starsText(n: number): string {
    if (!n) return '';
    return ('★'.repeat(Math.round(n / 2))) + ('☆'.repeat(5 - Math.round(n / 2)));
  }

  getScore(): number {
    return this.hoverStar() || this.calificacionForm.puntuacion || 0;
  }

  close() {
    this.closed.emit();
  }

  onOverlayClick(e: MouseEvent) {
    if ((e.target as HTMLElement).classList.contains('modal-overlay')) {
      this.close();
    }
  }
}
