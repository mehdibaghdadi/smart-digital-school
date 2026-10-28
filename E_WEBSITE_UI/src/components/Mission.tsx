import React from 'react';
import { motion } from 'motion/react';
import { Zap, Smartphone, Users } from 'lucide-react';
import { Language, translations } from '../translations';

export const Mission = ({ lang }: { lang: Language }) => {
  const t = translations[lang].mission;
  const icons = [
    <Zap className="text-brand-600" size={32} />,
    <Smartphone className="text-blue-600" size={32} />,
    <Users className="text-purple-600" size={32} />,
  ];
  const colors = ["bg-brand-50 dark:bg-brand-900/30", "bg-blue-50 dark:bg-blue-900/30", "bg-purple-50 dark:bg-purple-900/30"];

  return (
    <section id="mission" className="py-16 bg-slate-50 dark:bg-dark-card/30 transition-colors">
      <div className="max-w-7xl mx-auto px-6">
        <div className="grid lg:grid-cols-2 gap-16 items-center mb-20">
          <div className="text-left">
            <h2 className="text-3xl uppercase  font-extrabold text-slate-900 dark:text-white mb-6">
              {t.title}
            </h2>
            <p className="text-xl text-slate-600 dark:text-slate-300">
              {t.desc}
            </p>
          </div>
          <motion.div 
            initial={{ opacity: 0, scale: 0.9 }}
            whileInView={{ opacity: 1, scale: 1 }}
            viewport={{ once: true }}
            transition={{ duration: 0.8 }}
            className="relative text-center flex justify-center lg:justify-end"
          >
            <img 
              src="/mission.gif" 
              alt="Mission" 
                          className="rounded-[40px] w-full lg:w-120 shadow-2xl border-8 border-white dark:border-dark-card"
              referrerPolicy="no-referrer"
            />
          </motion.div>
        </div>

        <div className="grid md:grid-cols-3 gap-8">
          {t.items.map((item, idx) => (
            <motion.div 
              key={idx}
              initial={{ opacity: 0, y: 50 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.8, ease: "easeOut", delay: idx * 0.2 }}
              whileHover={{ y: -10 }}
              className="bg-white dark:bg-dark-card p-10 rounded-3xl shadow-sm border border-slate-100 dark:border-slate-600"
            >
              <div className={`w-16 h-16 ${colors[idx]} rounded-2xl flex items-center justify-center mb-8`}>
                {icons[idx]}
              </div>
              <h3 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">{item.title}</h3>
              <p className="text-slate-600 dark:text-slate-300 leading-relaxed">{item.desc}</p>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
};
