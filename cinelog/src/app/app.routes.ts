import { Routes } from '@angular/router';
import { inject } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from './services/auth.service';

const authGuard = () => {
  const auth = inject(AuthService);
  const router = inject(Router);
  if (auth.isLoggedIn()) return true;
  return router.createUrlTree(['/login']);
};

export const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' },
  {
    path: 'login',
    loadComponent: () => import('./pages/login/login.component').then(m => m.LoginComponent)
  },
  {
    path: 'home',
    loadComponent: () => import('./pages/home/home.component').then(m => m.HomeComponent)
  },
  {
    path: 'mis-listas',
    canActivate: [authGuard],
    loadComponent: () => import('./pages/mis-listas/mis-listas.component').then(m => m.MisListasComponent)
  },
  {
    path: 'mis-finales',
    canActivate: [authGuard],
    loadComponent: () => import('./pages/mis-finales/mis-finales.component').then(m => m.MisFinalesComponent)
  },
  { path: '**', redirectTo: 'home' }
];
