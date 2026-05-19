import { Injectable, signal } from '@angular/core';
import { Router } from '@angular/router';
import { ApiService } from './api.service';

@Injectable({ providedIn: 'root' })
export class AuthService {
  usuario = signal<any>(null);

  constructor(private api: ApiService, private router: Router) {
    const stored = localStorage.getItem('cl_user');
    if (stored) this.usuario.set(JSON.parse(stored));
  }

  login(data: any): Promise<void> {
    return new Promise((resolve, reject) => {
      this.api.login(data).subscribe({
        next: (res: any) => {
          localStorage.setItem('cl_token', res.token);
          localStorage.setItem('cl_user', JSON.stringify(res.usuario));
          this.usuario.set(res.usuario);
          resolve();
        },
        error: reject
      });
    });
  }

  register(data: any): Promise<void> {
    return new Promise((resolve, reject) => {
      this.api.register(data).subscribe({
        next: (res: any) => {
          localStorage.setItem('cl_token', res.token);
          localStorage.setItem('cl_user', JSON.stringify(res.usuario));
          this.usuario.set(res.usuario);
          resolve();
        },
        error: reject
      });
    });
  }

  logout(): void {
    localStorage.removeItem('cl_token');
    localStorage.removeItem('cl_user');
    this.usuario.set(null);
    this.router.navigate(['/login']);
  }

  isLoggedIn(): boolean {
    return !!localStorage.getItem('cl_token');
  }
}
