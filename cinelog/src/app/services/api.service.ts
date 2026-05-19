import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({ providedIn: 'root' })
export class ApiService {
  private base = 'http://localhost:3000/api';

  constructor(private http: HttpClient) {}

  private headers(): HttpHeaders {
    const token = localStorage.getItem('cl_token');
    return token ? new HttpHeaders({ Authorization: `Bearer ${token}` }) : new HttpHeaders();
  }

  // Auth
  login(data: any): Observable<any> { return this.http.post(`${this.base}/auth/login`, data); }
  register(data: any): Observable<any> { return this.http.post(`${this.base}/auth/register`, data); }
  perfil(): Observable<any> { return this.http.get(`${this.base}/auth/perfil`, { headers: this.headers() }); }

  // Catálogo
  getContenidos(params?: any): Observable<any> { return this.http.get(`${this.base}/contenidos`, { params }); }
  getContenidosPorGenero(): Observable<any> { return this.http.get(`${this.base}/contenidos/por-genero`); }
  getTop10(): Observable<any> { return this.http.get(`${this.base}/contenidos/top10`); }
  getContenido(id: number): Observable<any> { return this.http.get(`${this.base}/contenidos/${id}`); }
  getEpisodios(idTemporada: number): Observable<any> { return this.http.get(`${this.base}/temporadas/${idTemporada}/episodios`); }

  // Géneros
  getGeneros(): Observable<any> { return this.http.get(`${this.base}/generos`); }

  // Calificaciones
  getCalificacion(idContenido: number): Observable<any> {
     return this.http.get(`${this.base}/calificaciones/${idContenido}`, {
       headers: this.headers()
     });
  }
  guardarCalificacion(data: any): Observable<any> {
    return this.http.post(`${this.base}/calificaciones`, data, {
      headers: this.headers()
    });
  }

  // Listas
  getListas(): Observable<any> { return this.http.get(`${this.base}/listas`, { headers: this.headers() }); }
  crearLista(data: any): Observable<any> { return this.http.post(`${this.base}/listas`, data, { headers: this.headers() }); }
  agregarALista(idLista: number, idContenido: number): Observable<any> { return this.http.post(`${this.base}/listas/${idLista}/contenidos`, { id_contenido: idContenido }, { headers: this.headers() }); }
  quitarDeLista(idLista: number, idContenido: number): Observable<any> { return this.http.delete(`${this.base}/listas/${idLista}/contenidos/${idContenido}`, { headers: this.headers() }); }
  eliminarLista(idLista: number): Observable<any> { return this.http.delete(`${this.base}/listas/${idLista}`, { headers: this.headers() }); }
  moverEnLista(idLista: number, idContenido: number, direccion: string): Observable<any> {
    return this.http.patch(`${this.base}/listas/${idLista}/contenidos/${idContenido}/mover`, { direccion }, { headers: this.headers() });
  }

  // Finales alternativos
  getFinal(idContenido: number): Observable<any> {
    return this.http.get(`${this.base}/finales/${idContenido}`, {
      headers: this.headers()
    });
  }

  getTodosFinales(idContenido: number): Observable<any> {
    return this.http.get(`${this.base}/finales/${idContenido}/todos`);
  }

  guardarFinal(data: any): Observable<any> {
    return this.http.post(`${this.base}/finales`, data, {
      headers: this.headers()
    });
  }
  getMisFinales(): Observable<any> { return this.http.get(`${this.base}/mis-finales`, { headers: this.headers() }); }
}
